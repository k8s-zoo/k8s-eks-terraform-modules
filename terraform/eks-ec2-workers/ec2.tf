resource "aws_security_group" "worker-node" {
  name        = local.name_prefix
  description = "Security group for all nodes in the cluster"
  vpc_id      = var.cluster_vpc_id

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  tags = {
    Name                                                             = local.name_prefix
    owner                                                            = var.owner
    stack                                                            = var.stack
    env                                                              = var.env
    "kubernetes.io/cluster/${data.aws_eks_cluster.eks-cluster.name}" = "owned"
  }
}

resource "aws_security_group_rule" "worker-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.worker-node.id
  source_security_group_id = aws_security_group.worker-node.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker-node.id
  source_security_group_id = var.cluster_master_sg_id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = var.cluster_master_sg_id
  source_security_group_id = aws_security_group.worker-node.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_launch_configuration" "worker-lc" {
  name                        = local.name_prefix
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = aws_iam_instance_profile.worker-instance-profile.name
  image_id                    = data.aws_ami.eks-worker.id
  instance_type               = var.worker_instance_type
  security_groups = join([
    aws_security_group.worker-node.id
  ], var.worker_sg)
  user_data = data.template_file.ec2_userdata.rendered

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name  = local.name_prefix
    owner = var.owner
    stack = var.stack
    env   = var.env
  }
}

resource "aws_autoscaling_group" "worker-asg" {
  desired_capacity     = var.worker_asg_desired_capacity
  launch_configuration = aws_launch_configuration.worker-lc.id
  max_size             = var.worker_asg_max_capacity
  min_size             = var.worker_asg_min_capacity
  name                 = local.name_prefix
  vpc_zone_identifier  = var.cluster_subnets

  tag {
    key                 = "Name"
    value               = local.name_prefix
    propagate_at_launch = true
  }

  tag {
    key                 = "owner"
    value               = var.owner
    propagate_at_launch = true
  }

  tag {
    key                 = "stack"
    value               = var.stack
    propagate_at_launch = true
  }

  tag {
    key                 = "env"
    value               = var.env
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${data.aws_eks_cluster.eks-cluster.name}"
    value               = "owned"
    propagate_at_launch = true
  }
}