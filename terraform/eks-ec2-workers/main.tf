terraform {
  required_version = ">0.12"
}

locals {
  name_prefix = "${data.aws_eks_cluster.eks-cluster.name}-eks-worker"
}