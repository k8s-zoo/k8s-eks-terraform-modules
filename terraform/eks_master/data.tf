data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "master-node-assume-policy" {

  statement {

    effect = "Allow"
    principals {
      identifiers = ["eks.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

data "template_file" "kubeconfig" {
  template = file("${path.module}/kubeconfig.yml")

  vars = {
    eks_master_endpoint = aws_eks_cluster.master.endpoint
    eks_master_cert     = aws_eks_cluster.master.certificate_authority.0.data
    eks_master_name     = var.cluster_name
  }
}

data "aws_eks_cluster_auth" "eks-cluster" {
  name = aws_eks_cluster.master.id
}