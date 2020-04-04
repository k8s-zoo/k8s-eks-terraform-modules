module "eks-node-group" {
  source = "../../terraform/eks_node_group"

  aws_region            = var.aws_region
  cluster_id            = var.eks_master_id
  cluster_master_sg_id  = var.eks_master_sg_id
  node_group_name       = var.eks_node_group_name
  node_vpc_id           = data.aws_vpc.vpc.id
  node_subnets          = data.aws_subnet_ids.subnets.ids
  node_labels           = var.eks_node_labels
  node_ssh_keypair_name = var.eks_nodes_keypair
  owner                 = var.owner
  stack                 = var.stack
  env                   = var.env
}

resource "aws_security_group_rule" "allow-local-access" {
  description       = "Allow node to communicate from VPN"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = var.access_cidr_blocks
  security_group_id = module.eks-node-group.node_sg_id
}