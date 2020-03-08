resource "aws_eks_cluster" "master" {
  name            = var.cluster_name
  role_arn        = aws_iam_role.master-node.arn

  vpc_config {
    security_group_ids = [aws_security_group.master-cluster.id]
    subnet_ids         = var.cluster_subnets
  }

  depends_on = [
    aws_iam_role_policy_attachment.master-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.master-cluster-AmazonEKSServicePolicy,
  ]
}