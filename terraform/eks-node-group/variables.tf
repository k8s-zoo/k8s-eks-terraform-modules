variable "aws_region" {
  type = string
}

# Cluster

variable "cluster_id" {
  type = string
}

variable "cluster_version" {
  type    = number
  default = 1.14
}

variable "cluster_master_sg_id" {
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

variable "node_labels" {
  type = map(string)
}

variable "instance_types" {
  type    = string
  default = "t3.medium"
}

variable "instance_disk_size" {
  type    = number
  default = 50
}

variable "ami_type" {
  type    = string
  default = "AL2_x86_64"
}

variable "scaling_desiered_size" {
  type    = number
  default = 1
}

variable "scaling_max_size" {
  type    = number
  default = 5
}

variable "scaling_min_size" {
  type    = number
  default = 1
}

variable "node_ssh_keypair_name" {
  type = string
}

variable "node_source_security_group_ids" {
  type = set(string)
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