resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true

  tags = {
    Name    = local.name_prefix
    Cluster = var.cluster_name
    owner   = var.owner
    stack   = var.stack
    env     = var.env
  }
}