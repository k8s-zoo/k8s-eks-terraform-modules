resource "aws_iam_role" "example" {
  name               = local.name_prefix
  assume_role_policy = data.aws_iam_policy_document.worker-node-assume-policy.json
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = data.aws_iam_policy.eks_worker_node_policy.arn
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = data.aws_iam_policy.eks_cni_policy.arn
  role       = aws_iam_role.example.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = data.aws_iam_policy.ecs_container_registry_policy.arn
  role       = aws_iam_role.example.name
}