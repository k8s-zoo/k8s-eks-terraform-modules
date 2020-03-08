variable "aws_reigon" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_vpc_id" {
  type = string
}

variable "cluster_subnets" {
  type = list(string)
}

variable "cluster_master_sg_id" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_cert_autority_data" {
  type = string
}