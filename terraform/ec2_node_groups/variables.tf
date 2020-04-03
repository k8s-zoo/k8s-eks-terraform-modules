variable "aws_region" {
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

# Luanch Configurations

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "worker_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "worker_keypair_name" {
  type = string
}

variable "worker_sg" {
  type    = list(string)
  default = []
}

# ASG

variable "worker_asg_desired_capacity" {
  type    = number
  default = 1
}

variable "worker_asg_min_capacity" {
  type    = number
  default = 1
}

variable "worker_asg_max_capacity" {
  type    = number
  default = 5
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