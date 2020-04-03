provider "aws" {
  region = var.aws_region
}

module "eks-cluster-worker" {
  source = "../../terraform/ec2_node_groups"

  aws_region           = var.aws_region
  cluster_id           = var.eks_master_id
  cluster_vpc_id       = data.aws_vpc.vpc.id
  cluster_subnets      = data.aws_subnet_ids.subnets.ids
  cluster_master_sg_id = var.master_sg_id
  worker_keypair_name  = "cicd-jenkins"
  owner                = var.owner
  stack                = var.stack
  env                  = var.env
}

resource "aws_security_group_rule" "allow-local-access" {
  description = "Allow node to communicate from VPN"
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = [
    "10.0.0.0/8"
  ]
  security_group_id = module.eks-cluster-worker.node_cluster_sg_id
}
