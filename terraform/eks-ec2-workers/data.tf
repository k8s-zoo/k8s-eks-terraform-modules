data "aws_ami" "eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${data.aws_eks_cluster.cluster.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"] # Amazon EKS AMI Account ID
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_id
}

data "template_file" "ec2_userdata" {
  template = "${path.module}/ec2-userdata.sh"

  vars = {
    cluster_name                  = data.aws_eks_cluster.cluster.name
    cluster_endpoint              = data.aws_eks_cluster.cluster.endpoint
    cluster_certificate_authority = data.aws_eks_cluster.cluster.certificate_authority.0.data
  }
}