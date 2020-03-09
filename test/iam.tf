resource "aws_security_group" "master-cluster-local-access" {
  name        = "${var.cluster_name}-local-access"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.local_public_ip]
  }

  tags = {
    Name = "${var.cluster_name}-local-access"
    owner = var.owner
    stack = var.stack
    env = var.env
  }
}