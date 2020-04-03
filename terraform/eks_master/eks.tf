resource "aws_eks_cluster" "master" {
  name     = var.cluster_name
  role_arn = aws_iam_role.master-node.arn

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
    subnet_ids              = var.cluster_subnets
    security_group_ids      = concat(var.security_group_ids, [aws_security_group.master-cluster.id])
  }

  enabled_cluster_log_types = var.log_types

  tags = {
    owner = var.owner
    stack = var.stack
    env   = var.env
  }

  lifecycle {
    create_before_destroy = false
  }

  version = var.cluster_version

  depends_on = [
    aws_iam_role_policy_attachment.master-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.master-cluster-AmazonEKSServicePolicy,
    aws_cloudwatch_log_group.master-cluster-cw-loggroup
  ]
}