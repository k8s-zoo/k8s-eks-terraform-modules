output "node_group_id" {
  value = aws_eks_node_group.eks-node-group.id
}

output "node_sg_id" {
  value = aws_security_group.node-security-group.id
}

output "node_sg_name" {
  value = aws_security_group.node-security-group.name
}