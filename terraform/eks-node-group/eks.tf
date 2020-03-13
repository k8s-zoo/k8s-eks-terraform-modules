resource "aws_eks_node_group" "example" {
  cluster_name    = data.aws_eks_cluster.eks-cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.example.arn
  subnet_ids      = var.node_subnets

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}