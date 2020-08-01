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

## Public Subnet Setup

resource "aws_subnet" "eks_public_subnet" {
  count = length(data.aws_availability_zones.current.names)
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = "10.0.${10+count.index}.0/24"
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

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name    = local.name_prefix
    Cluster = var.cluster_name
    owner   = var.owner
    stack   = var.stack
    env     = var.env
  }
}

resource "aws_route" "eks_rt_igw" {
  route_table_id = aws_vpc.eks_vpc.main_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.eks_igw.id
}

## Private Subnet Setup

resource "aws_subnet" "eks_private_subnet" {
  count = length(data.aws_availability_zones.current.names)
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = "10.0.${20+count.index}.0/24"
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

//resource "aws_nat_gateway" "eks_gw" {
//  count = aws_subnet.eks_private_subnet.count
//  allocation_id = aws_eip.nat.id
//  subnet_id     = aws_subnet.example.id
//
//  tags = {
//    Name    = local.name_prefix
//    Cluster = var.cluster_name
//    owner   = var.owner
//    stack   = var.stack
//    env     = var.env
//  }
//}