## Private Subnet Setup

resource "aws_subnet" "eks_private_subnet" {
  count = length(data.aws_availability_zones.current.names)
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = "10.0.${20+count.index}.0/24"
  availability_zone = element(data.aws_availability_zones.current.names, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = local.name_prefix
    Cluster = var.cluster_name
    owner = var.owner
    stack = var.stack
    env = var.env
  }
}

resource "aws_eip" "eks_private_nat_gw_eip" {
  tags = {
    Name = local.name_prefix
    Cluster = var.cluster_name
    owner = var.owner
    stack = var.stack
    env = var.env
  }
}

resource "aws_nat_gateway" "eks_private_nat_gw" {
  allocation_id = aws_eip.eks_private_nat_gw_eip.id
  subnet_id = element(aws_subnet.eks_private_subnet.*.id, 0)

  tags = {
    Name = local.name_prefix
    Cluster = var.cluster_name
    owner = var.owner
    stack = var.stack
    env = var.env
  }
}

resource "aws_route" "eks_private_nat_route" {
  route_table_id = aws_vpc.eks_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.eks_private_nat_gw.id
}

resource "aws_route_table_association" "eks_private_rt_association" {
  count = length(aws_subnet.eks_private_subnet.*.id)
  subnet_id      = element(aws_subnet.eks_private_subnet.*.id, count.index)
  route_table_id = aws_vpc.eks_vpc.main_route_table_id
}