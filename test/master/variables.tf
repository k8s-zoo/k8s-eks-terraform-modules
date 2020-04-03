variable "aws_region" {
  default = "us-west-2"
}

# EKS Master

variable "cluster_name" {
  default = "mishah-learn"
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