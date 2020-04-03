output "config_map_aws_auth" {
  value = data.template_file.kubernetes_configmap.rendered
}

output "node_cluster_sg_id" {
  value = aws_security_group.worker-node.id
}

output "node_cluster_asg" {
  value = aws_autoscaling_group.worker-asg.name
}

output "node_cluster_lt" {
  value = aws_launch_template.worker-lt.name
}

output "node_cluster_instance_profile_name" {
  value = aws_iam_instance_profile.worker-instance-profile.name
}

output "node_cluster_role" {
  value = aws_iam_role.worker-instacne-role.name
}