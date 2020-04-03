terraform {
  required_version = ">0.12"
}

locals {
  name_prefix = "${var.node_group_name}-eks-node"
}