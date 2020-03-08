variable "aws_reigon" {
  type = string
}

variable "cluster_id" {
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