terraform {
  required_version = ">0.12"
}

locals {
  name_prefix = "${data.aws_eks_cluster.eks-cluster.name}-eks-worker"
}

resource "local_file" "k8s_config_map" {
  content  = data.template_file.kubernetes_configmap.rendered
  filename = "${path.module}/k8s_config_map_aws_auth.yaml"
}