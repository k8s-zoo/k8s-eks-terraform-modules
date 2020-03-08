provider "aws" {
  region = var.aws_region
}

terraform {
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = ">= 0.12.0"
}

variable "aws_region" {
  default = "us-west-2"
}


data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["PrimaryVPC"]
  }
}

data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Tier = "App"
  }
}

module "eks-cluster-master" {
  source = "../terraform/master"

  aws_reigon = var.aws_region
  cluster_name = "mishal-learn-eks"
  cluster_vpc_id = data.aws_vpc.vpc.id
  cluster_subnets = data.aws_subnet_ids.subnets.ids
}

module "eks-cluster-worker" {
  source = "../terraform/workers"

  aws_reigon = var.aws_region
  cluster_name = "mishal-learn-eks"
  cluster_vpc_id = data.aws_vpc.vpc.id
  cluster_subnets = data.aws_subnet_ids.subnets.ids
  cluster_master_sg_id = module.eks-cluster-master.master_sg_id
  cluster_version = module.eks-cluster-master.cluter_version
  cluster_endpoint = module.eks-cluster-master.cluster_endpoint
  cluster_cert_autority_data = module.eks-cluster-master.cluster_cert_authorith_data
}

output "master-kubeconfig" {
  value = module.eks-cluster-master.kubeconfig
}

output "master-config_map_aws_auth" {
  value = module.eks-cluster-worker.config_map_aws_auth
}