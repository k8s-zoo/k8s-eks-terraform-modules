resource "aws_iam_instance_profile" "worker-instance-profile" {
  name = "${local.name_prefix}-${data.aws_region.current.name}"
  role = aws_iam_role.worker-instacne-role.name

  depends_on = [aws_iam_role.worker-instacne-role]
}

resource "aws_iam_role" "worker-instacne-role" {
  name               = "${local.name_prefix}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2-assume-policy.json

  tags = {
    Name  = "${local.name_prefix}-ec2-role"
    owner = var.owner
    stack = var.stack
    env   = var.env
  }

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_iam_role_policy_attachment" "worker-instance-AmazonEKSWorkerNodePolicy" {
  policy_arn = data.aws_iam_policy.eks_worker_node_policy.arn
  role       = aws_iam_role.worker-instacne-role.name
}

resource "aws_iam_role_policy_attachment" "worker-instance-AmazonEKS_CNI_Policy" {
  policy_arn = data.aws_iam_policy.eks_cni_policy.arn
  role       = aws_iam_role.worker-instacne-role.name
}

resource "aws_iam_role_policy_attachment" "worker-instance-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = data.aws_iam_policy.ecs_container_registry_policy.arn
  role       = aws_iam_role.worker-instacne-role.name
}