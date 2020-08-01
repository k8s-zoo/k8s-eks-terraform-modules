output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "vpc_main__rt" {
  value = aws_vpc.eks_vpc.main_route_table_id
}

output "public_subnets" {
  value = [aws_subnet.eks_public_subnet.*.id]
}

output "public_rt" {
  value = aws_route_table.eks_public_subnets_rt.id
}

output "private_subnets" {
  value = [aws_subnet.eks_private_subnet.*.id]
}

output "nat_gateway" {
  value = aws_nat_gateway.eks_private_nat_gw.id
}

output "internet_gateway" {
  value = aws_internet_gateway.eks_public_ig.id
}