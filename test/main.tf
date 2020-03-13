provider "aws" {
  region = var.aws_region
}

module "eks-cluster-master" {
  source = "../terraform/eks-master"

  aws_region              = var.aws_region
  cluster_name            = var.cluster_name
  cluster_vpc_id          = data.aws_vpc.vpc.id
  cluster_subnets         = data.aws_subnet_ids.subnets.ids
  endpoint_private_access = true
  endpoint_public_access  = false
  owner                   = var.owner
  stack                   = var.stack
  env                     = var.env
}

module "eks-cluster-worker" {
  source = "../terraform/eks-ec2-workers"

  aws_region           = var.aws_region
  cluster_id           = module.eks-cluster-master.cluster_id
  cluster_vpc_id       = data.aws_vpc.vpc.id
  cluster_subnets      = data.aws_subnet_ids.subnets.ids
  cluster_master_sg_id = module.eks-cluster-master.master_sg_id
  worker_keypair_name = "cicd-jenkins"
  owner                = var.owner
  stack                = var.stack
  env                  = var.env
}

module "eks-node-group" {
  source = "../terraform/eks-node-group"

  aws_region           = var.aws_region
  cluster_id           = module.eks-cluster-master.cluster_id
  cluster_master_sg_id = module.eks-cluster-master.master_sg_id
  node_group_name      = "mishal-learn-node-grp"
  node_vpc_id          = data.aws_vpc.vpc.id
  node_subnets         = data.aws_subnet_ids.subnets.ids
  node_labels = {
    "env" = "test"
  }
  node_ssh_keypair_name = "cicd-jenkins"
  owner                 = var.owner
  stack                 = var.stack
  env                   = var.env
}
