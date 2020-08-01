data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_availability_zones" "current" {}

data "aws_route_table" "eks_public_subnet_rt" {
  subnet_id = element(aws_subnet.eks_public_subnet, 0)
}

data "aws_route_table" "eks_private_subnet_rt" {
  subnet_id = element(aws_subnet.eks_private_subnet, 0)
}