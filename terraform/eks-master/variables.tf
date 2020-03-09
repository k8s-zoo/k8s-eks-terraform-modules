variable "aws_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type    = number
  default = 1.14
}

variable "cluster_vpc_id" {
  type = string
}

variable "cluster_subnets" {
  type = list(string)
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "endpoint_private_access" {
  type    = bool
  default = false
}

variable "endpoint_public_access" {
  type    = bool
  default = true
}

variable "public_access_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "log_retention_in_days" {
  type    = number
  default = 7
}

variable "log_types" {
  type = list(string)
  default = [
    "api",
    "audit"
  ]
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