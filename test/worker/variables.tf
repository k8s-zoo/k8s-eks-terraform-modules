variable "aws_region" {
  default = "us-west-2"
}

variable "eks_master_id" {
  type    = string
  default = "mishah-learn"
}

variable "master_sg_id" {
  type    = string
  default = "sg-02a2b52b83914b09f"
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