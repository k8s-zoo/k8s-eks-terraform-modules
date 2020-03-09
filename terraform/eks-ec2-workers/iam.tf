resource "aws_iam_role" "worker-cluster" {
  name               = local.name_prefix
  path               = local.path_prefix
  assume_role_policy = data.aws_iam_policy_document.eks-assume-policy.json

  tags = {
    Name  = local.name_prefix
    owner = var.owner
    stack = var.stack
    env   = var.env
  }
}

resource "aws_iam_role_policy_attachment" "worker-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.worker-cluster.name
}

resource "aws_iam_role_policy_attachment" "worker-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.worker-cluster.name
}

# Instance profile

resource "aws_iam_instance_profile" "worker-instance-profile" {
  name = "${local.name_prefix}-instance-profile"
  path = local.path_prefix
  role = aws_iam_role.worker-instacne-role.name
}

resource "aws_iam_role" "worker-instacne-role" {
  name               = "${local.name_prefix}-ec2-role"
  path               = local.path_prefix
  assume_role_policy = data.aws_iam_policy_document.ec2-assume-policy.json

  tags = {
    Name  = "${local.name_prefix}-ec2-role"
    owner = var.owner
    stack = var.stack
    env   = var.env
  }
}

resource "aws_iam_role_policy_attachment" "worker-instance-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker-instacne-role.name
}

resource "aws_iam_role_policy_attachment" "worker-instance-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker-instacne-role.name
}

resource "aws_iam_role_policy_attachment" "worker-instance-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker-instacne-role.name
}