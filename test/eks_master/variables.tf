variable "aws_region" {
  default = "us-west-2"
}

# EKS Master

variable "eks_cluster_name" {
  type = string
}

variable "endpoint_private_access" {
  type    = bool
  default = true
}

variable "endpoint_public_access" {
  type    = bool
  default = false
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

variable "tool" {
  type    = string
  default = "Managed by Terraform"
}