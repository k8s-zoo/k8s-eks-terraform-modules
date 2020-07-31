terraform {
  required_version = ">0.12"
}

locals {
  name_prefix = "${var.cluster_name}-eks-master"
}