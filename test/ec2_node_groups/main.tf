provider "aws" {
  region = var.aws_region
}

module "eks-cluster-worker" {
  source = "../../terraform/ec2_node_group"

  cluster_id          = var.eks_cluster_name
  worker_keypair_name = var.eks_nodes_keypair
  owner               = var.owner
  stack               = var.stack
  env                 = var.env
}

resource "aws_security_group_rule" "allow-local-access" {
  description       = "Allow node to communicate from VPN"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = var.access_cidr_blocks
  security_group_id = module.eks-cluster-worker.node_cluster_sg_id
}
