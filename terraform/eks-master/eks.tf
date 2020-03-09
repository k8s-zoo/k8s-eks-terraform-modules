resource "aws_eks_cluster" "master" {
  name = var.cluster_name
  role_arn = aws_iam_role.master-node.arn

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access = var.endpoint_public_access
    security_group_ids = join(var.security_group_ids, [aws_security_group.master-cluster.id])
    subnet_ids = var.cluster_subnets
  }

  enabled_cluster_log_types = var.log_types

  tags = {
    owner = var.owner
    stack = var.stack
    env = var.env
  }

  version = var.cluster_version

  depends_on = [
    aws_iam_role_policy_attachment.master-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.master-cluster-AmazonEKSServicePolicy,
  ]
}