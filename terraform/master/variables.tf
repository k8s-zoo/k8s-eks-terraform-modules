variable "aws_reigon" {
  type = string
}

variable "cluster_name" {
  type    = string
  default = "mishal-learn"
}

variable "cluster_vpc_id" {
  type = string
}

variable "cluster_subnets" {
  type = list(string)
}