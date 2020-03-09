output "cluster_id" {
  value = module.eks-cluster-master.cluster_id
}

//output "config_map_aws_auth" {
//  value = module.eks-cluster-worker.config_map_aws_auth
//}