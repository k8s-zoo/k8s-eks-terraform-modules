variable "aws_region" {
  default = "us-west-2"
}

# EKS master

variable "eks_master_id" {
  type = string
}

variable "eks_master_sg_id" {
  type = string
}

# EKS nodes

variable "eks_node_group_name" {
  type = string
}

variable "eks_nodes_keypair" {
  type = string
}

variable "eks_node_labels" {
  type = map(string)
  default = {
    "env" = "test"
  }
}

variable "access_cidr_blocks" {
  type    = list(string)
  default = []
}

# Tags

variable "owner" {
  default = "mishah@groupon.com"
}

variable "stack" {
  default = "jenkins"
}

variable "env" {
  default = "learn"
}