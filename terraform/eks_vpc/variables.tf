variable "cluster_name" {
  type = string
}

variable "vpc_cid_block" {
  type    = string
  default = "10.0.0.0/16"
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