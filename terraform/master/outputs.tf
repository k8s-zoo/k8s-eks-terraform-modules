output "kubeconfig" {
  value = local.kubeconfig
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
output "cluster_cert_authorith_data" {
  value = aws_eks_cluster.master.certificate_authority[0].data
}