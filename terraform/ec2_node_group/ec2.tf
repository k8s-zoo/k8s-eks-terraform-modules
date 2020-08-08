resource "aws_security_group" "worker-node" {
  name        = local.name_prefix
  description = "Security group for all nodes in the cluster"
  vpc_id      = data.aws_eks_cluster.eks-cluster.vpc_config.0.vpc_id

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
  description              = "Allow nodes to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.worker-node.id
  source_security_group_id = aws_security_group.worker-node.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-node-ingress-cluster" {
  description              = "Allow node Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker-node.id
  source_security_group_id = data.aws_eks_cluster.eks-cluster.vpc_config.0.cluster_security_group_id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-cluster-ingress-node-https" {
  description              = "Allow pods to receive communication from cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = data.aws_eks_cluster.eks-cluster.vpc_config.0.cluster_security_group_id
  source_security_group_id = aws_security_group.worker-node.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "master-cluster-ingress-node-https" {
  description              = "Allow API Server to receive communication from pods."
  from_port                = 443
  protocol                 = "tcp"
  to_port                  = 443
  security_group_id        = aws_security_group.worker-node.id
  source_security_group_id = data.aws_eks_cluster.eks-cluster.vpc_config.0.cluster_security_group_id
  type                     = "ingress"
}

resource "aws_launch_template" "worker-lt" {
  name                                 = local.name_prefix
  image_id                             = data.aws_ami.eks-worker.id
  instance_type                        = var.worker_instance_type
  instance_initiated_shutdown_behavior = "terminate"

  iam_instance_profile {
    name = aws_iam_instance_profile.worker-instance-profile.name
  }

  key_name = var.worker_keypair_name
  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
    delete_on_termination       = true
    subnet_id                   = element(tolist(data.aws_eks_cluster.eks-cluster.vpc_config.0.subnet_ids), 0)
    security_groups = concat([
      aws_security_group.worker-node.id
    ], var.worker_sg)
  }
  user_data = base64encode(data.template_file.ec2_userdata.rendered)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "worker-asg" {
  desired_capacity = var.worker_asg_desired_capacity
  launch_template {
    id      = aws_launch_template.worker-lt.id
    version = "$Latest"
  }
  max_size            = var.worker_asg_max_capacity
  min_size            = var.worker_asg_min_capacity
  name                = local.name_prefix
  vpc_zone_identifier = data.aws_eks_cluster.eks-cluster.vpc_config.0.subnet_ids

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