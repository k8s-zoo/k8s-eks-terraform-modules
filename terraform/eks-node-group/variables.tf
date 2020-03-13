variable "aws_region" {
  type = string
}

# Cluster

variable "cluster_id" {
  type = string
}

# Node variables

variable "node_group_name" {
  type = string
}

variable "node_vpc_id" {
  type = string
}

variable "node_subnets" {
  type = list(string)
}

# Tags

variable "owner" {
  type = string
}

variable "stack" {
  type = string
}

variable "env" {
  type = string
}

variable "tool" {
  type    = string
  default = "Managed by Terraform"
}