variable "aws_region" {
  default = "us-west-2"
}

provider "aws" {
  region = var.aws_region
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
  source = "../terraform/eks-master"

  aws_reigon = var.aws_region
  cluster_name = "mishal-learn-eks"
  cluster_vpc_id = data.aws_vpc.vpc.id
  cluster_subnets = data.aws_subnet_ids.subnets.ids
}

module "eks-cluster-worker" {
  source = "../terraform/eks-ec2-workers"

  aws_reigon = var.aws_region
  cluster_id = module.eks-cluster-master.cluster_id
  cluster_vpc_id = data.aws_vpc.vpc.id
  cluster_subnets = data.aws_subnet_ids.subnets.ids
  cluster_master_sg_id = module.eks-cluster-master.master_sg_id

}