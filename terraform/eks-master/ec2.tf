resource "aws_security_group" "master-cluster" {
  name        = local.name_prefix
  description = "Cluster master allow communication with worker nodes."
  vpc_id      = var.cluster_vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = local.name_prefix
    owner = var.owner
    stack = var.stack
    env   = var.env
  }
}