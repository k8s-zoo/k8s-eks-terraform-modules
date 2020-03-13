output "node_group_arn" {
  value = aws_eks_node_group.eks-node-group.arn
}

output "node_group_id" {
  value = aws_eks_node_group.eks-node-group.id
}

output "node_group_status" {
  value = aws_eks_node_group.eks-node-group.status
}

output "node_group_resources_name" {
  value = aws_eks_node_group.eks-node-group.resources.name
}

output "node_group_resources_asg" {
  value = aws_eks_node_group.eks-node-group.resources.autoscaling_groups
}

output "node_group_resources_remote_sg" {
  value = aws_eks_node_group.eks-node-group.resources.remote_access_security_group_id
}