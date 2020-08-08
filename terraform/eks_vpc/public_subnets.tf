## Public Subnet Setup

resource "aws_subnet" "eks_public_subnet" {
  count                   = length(data.aws_availability_zones.current.names)
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.${10 + count.index}.0/24"
  availability_zone       = element(data.aws_availability_zones.current.names, count.index)
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name                                        = "${local.name_prefix}-public"
    Type                                        = "public",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = 1
  })
}

resource "aws_internet_gateway" "eks_public_ig" {
  vpc_id = aws_vpc.eks_vpc.id
  tags   = local.common_tags
}

resource "aws_route_table" "eks_public_subnets_rt" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_public_ig.id
  }

  tags = merge(local.common_tags, {
    Vpc  = aws_vpc.eks_vpc.id
    Type = "public",
  })
}

resource "aws_route_table_association" "eks_public_rt_association" {
  count          = length(aws_subnet.eks_public_subnet.*.id)
  subnet_id      = element(aws_subnet.eks_public_subnet.*.id, count.index)
  route_table_id = aws_route_table.eks_public_subnets_rt.id
}