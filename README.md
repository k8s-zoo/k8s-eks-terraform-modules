# K8s EKS Terraform Modules

## Introduction

Terraform modules for creating kubernetes master and worker cluster on AWS [EKS](https://aws.amazon.com/eks/).

**Terraform version**: `0.12.23`

## List of modules

- [eks_vpc](terraform/eks_vpc)
- [eks_master](terraform/eks_master)
- [eks_node_group](terraform/eks_node_group)
- [ec2_node_group](terraform/ec2_node_group)

## Post operations

- After deploying EKS master, you have to update local kubernetes config. 

```shell script
$ aws eks --region {aws_region} update-kubeconfig --name {cluster_name}
```

-  Apply Kubernetes config

```shell script
$ kubectl apply -f k8s_config_map_aws_auth.yaml
```

-  To view nodes

```shell script
$ kubectl get nodes --watch
```
    
### Overview

- **Maintainer**: mishalshah92@gmail.com