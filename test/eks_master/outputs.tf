output "cluster_id" {
  value = module.eks-cluster-master.cluster_id
}

output "master_sg_id" {
  value = module.eks-cluster-master.master_sg_id
}