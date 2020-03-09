variable "aws_region" {
  default = "us-west-2"
}

# EKS Master

variable "cluster_name" {
  default = "mishal-learn"
}

# Inputs

variable "local_public_ip" {
  default = "203.192.204.136/32"
}

# Tags

variable "owner" {
  default = "mishah@groupon.com"
}

variable "stack" {
  default = "jenkins"
}

variable "env" {
  default = "env"
}

variable "tool" {
  type = string
  default = "Managed by Terraform"
}