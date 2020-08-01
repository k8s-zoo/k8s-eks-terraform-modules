terraform {
  required_version = ">0.12"
}

locals {
  common_tags = {
    Name = local.name_prefix
    Cluster = var.cluster_name
    Owner = var.owner
    Stack = var.stack
    Env = var.env
  }

  name_prefix = "${var.cluster_name}-eks"
}