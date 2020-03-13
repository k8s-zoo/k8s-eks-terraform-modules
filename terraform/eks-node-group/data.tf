data "aws_caller_identity" "current" {
}

data "aws_eks_cluster" "eks-cluster" {
  name = var.cluster_id
}

data "aws_eks_cluster_auth" "eks-cluster" {
  name = var.cluster_id
}


data "aws_iam_policy_document" "worker-node-assume-policy" {

  statement {

    effect = "Allow"
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy" "eks_cni_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

data "aws_iam_policy" "eks_worker_node_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

data "aws_iam_policy" "ecs_container_registry_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}