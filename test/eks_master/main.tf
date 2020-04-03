provider "aws" {
  region = var.aws_region
}

module "eks-cluster-master" {
  source = "../../terraform/eks_master"

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

resource "aws_security_group_rule" "allow-local-access" {
  description = "Allow node to communicate from VPN"
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = [
    "10.0.0.0/8"
  ]
  security_group_id = module.eks-cluster-master.master_sg_id
}
