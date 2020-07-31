resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cid_block
  enable_dns_support = true

  tags = {
    Name    = local.name_prefix
    Cluster = var.cluster_name
    owner   = var.owner
    stack   = var.stack
    env     = var.env
  }
}

resource "aws_subnet" "eks_public_subnet" {
  count = length(data.aws_availability_zones.current.names)
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = "10.20.${10+count.index}.0/24"
  availability_zone= element(data.aws_availability_zones.current.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name    = local.name_prefix
    Cluster = var.cluster_name
    owner   = var.owner
    stack   = var.stack
    env     = var.env
  }
}

resource "aws_subnet" "eks_private_subnet" {
  count = length(data.aws_availability_zones.current.names)
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = "10.20.${20+count.index}.0/24"
  availability_zone= element(data.aws_availability_zones.current.names, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name    = local.name_prefix
    Cluster = var.cluster_name
    owner   = var.owner
    stack   = var.stack
    env     = var.env
  }
}