resource "aws_security_group" "node-security-group" {
  name        = local.name_prefix
  description = "Security group for all nodes in the cluster"
  vpc_id      = var.node_vpc_id

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

resource "aws_security_group_rule" "node-security-group-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.node-security-group.id
  source_security_group_id = aws_security_group.node-security-group.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "node-security-group-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.node-security-group.id
  #source_security_group_id = var.cluster_master_sg_id
  source_security_group_id = data.aws_eks_cluster.eks-cluster.vpc_config['luster_security_group_id']
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  #security_group_id        = var.cluster_master_sg_id
  security_group_id = data.aws_eks_cluster.eks-cluster.vpc_config['luster_security_group_id']
  source_security_group_id = aws_security_group.node-security-group.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "master-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  to_port                  = 443
  security_group_id        = aws_security_group.node-security-group.id
  #source_security_group_id = var.cluster_master_sg_id
  source_security_group_id = data.aws_eks_cluster.eks-cluster.vpc_config['luster_security_group_id']
  type                     = "ingress"
}