data "aws_region" "current" {}

data "aws_eks_cluster" "eks-cluster" {
  name = var.cluster_id
}

data "aws_eks_cluster_auth" "eks-cluster" {
  name = var.cluster_id
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

data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${data.aws_eks_cluster.eks-cluster.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

data "template_file" "ec2_userdata" {
  template = file("${path.module}/ec2-userdata.sh")

  vars = {
    aws_region = data.aws_region.current.name
    cluster_name                  = data.aws_eks_cluster.eks-cluster.name
    cluster_endpoint              = data.aws_eks_cluster.eks-cluster.endpoint
    cluster_certificate_authority = data.aws_eks_cluster.eks-cluster.certificate_authority.0.data
  }
}

data "aws_iam_policy_document" "eks-assume-policy" {

  statement {

    effect = "Allow"
    principals {
      identifiers = ["eks.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "ec2-assume-policy" {

  statement {

    effect = "Allow"
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

data "template_file" "kubernetes_configmap" {
  template = file("${path.module}/config_map.yaml")

  vars = {
    node_iam_role = aws_iam_role.worker-instacne-role.arn
  }
}