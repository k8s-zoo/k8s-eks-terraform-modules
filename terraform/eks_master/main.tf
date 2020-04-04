terraform {
  required_version = ">0.12"
}

locals {
  name_prefix = "${var.cluster_name}-eks-master"
  eks_command = "aws eks --region ${data.aws_region.current.name} update-kubeconfig --name ${var.cluster_name}"
}

resource "local_file" "kubeconfig" {
  content  = data.template_file.kubeconfig.rendered
  filename = "kubeconfig.yaml"
}