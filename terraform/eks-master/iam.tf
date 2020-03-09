## IAM

resource "aws_iam_role" "master-node" {
  name = local.name_prefix
  path = local.path_prefix

  tags = {
    owner = var.owner
    stack = var.stack
    env   = var.env
  }

  assume_role_policy = data.aws_iam_policy_document.master-node-assume-policy.json
}

resource "aws_iam_role_policy_attachment" "master-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.master-node.name
}

resource "aws_iam_role_policy_attachment" "master-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.master-node.name
}