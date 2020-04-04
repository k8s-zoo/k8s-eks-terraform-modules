resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = data.aws_eks_cluster.eks-cluster.name
  labels          = var.node_labels
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.example.arn

  remote_access {
    ec2_ssh_key               = var.node_ssh_keypair_name
    source_security_group_ids = concat(var.node_source_security_group_ids, [aws_security_group.node-security-group.id])
  }

  subnet_ids = var.node_subnets

  scaling_config {
    desired_size = var.scaling_desiered_size
    max_size     = var.scaling_max_size
    min_size     = var.scaling_min_size
  }

  tags = {
    Name        = local.name_prefix
    eks-cluster = data.aws_eks_cluster.eks-cluster.name
    owner       = var.owner
    stack       = var.stack
    env         = var.env
  }

  version = data.aws_eks_cluster.eks-cluster.version

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}