# EKS Node Group

## Introduction

Terraform modules create Node Group on AWS EKS.

## Development

### Example

```hcl-terraform

provider "aws" {
  region = "us-west-2"
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["DefaultVPC"]
  }
}

data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Tier = "App"
  }
}

module "eks-cluster-master" {
  source = "git@github.com/k8s-zoo/k8s-eks-terraform-modules.git//terraform/eks_master"

  cluster_name            = "mishal-learn"
  cluster_vpc_id          = data.aws_vpc.vpc.id
  cluster_subnets         = data.aws_subnet_ids.subnets.ids
  endpoint_private_access = true
  endpoint_public_access  = false
  owner                   = "mishalshah92@gmail.com"
  stack                   = "demo"
  env                     = "learn"
}
module "eks-node-group" {
  source = "git@github.com/k8s-zoo/k8s-eks-terraform-modules.git//terraform/eks_node_group"

  cluster_id            = module.eks-cluster-master.cluster_id
  node_group_name       = "mishal-learn-eks-nodes"
  node_vpc_id           = data.aws_vpc.vpc.id
  node_subnets          = data.aws_subnet_ids.subnets.ids
  node_labels           = {
    "env" = "test"
  }
  node_ssh_keypair_name = "my-ssh-key"
  owner                 = "mishalshah92@gmail.com"
  stack                 = "demo"
  env                   = "learn"
}

resource "aws_security_group_rule" "allow-master-local-access" {
  description       = "Allow node to communicate from VPN"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [
    "0.0.0.0/0"
  ]
  security_group_id = module.eks-cluster-master.master_sg_id
}

resource "aws_security_group_rule" "allow-node-local-access" {
  description       = "Allow node to communicate from VPN"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [
    "0.0.0.0/0"
  ]
  security_group_id = module.eks-node-group.node_sg_id
}

```
 
**Variables**: For info on variables, check [file](variables.tf)