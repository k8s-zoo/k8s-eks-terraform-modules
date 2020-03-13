resource "aws_security_group_rule" "allow-local-access" {
  description = "Allow node to communicate with each other"
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = [
    "10.0.0.0/8"
  ]
  security_group_id = module.eks-cluster-master.master_sg_id
}