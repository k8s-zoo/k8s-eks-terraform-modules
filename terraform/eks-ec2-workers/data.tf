data "aws_eks_cluster" "eks-cluster" {
  name = var.cluster_id
}

data "aws_eks_cluster_auth" "eks-cluster" {
  name = var.cluster_id
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