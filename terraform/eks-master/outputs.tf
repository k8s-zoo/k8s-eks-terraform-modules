output "kubeconfig" {
  value = local.kubeconfig
}

output "master_iam_role" {
  value = aws_iam_role.master-node.id
}

output "master_sg_id" {
  value = aws_security_group.master-cluster.id
}

output "cluter_version" {
  value = aws_eks_cluster.master.version
}

output "cluster_endpoint" {
  value = aws_eks_cluster.master.endpoint
}

output "cluster_id" {
  value = aws_eks_cluster.master.id
}