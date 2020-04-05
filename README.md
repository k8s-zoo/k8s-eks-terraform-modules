# k8s-eks-terraform-modules

## Introduction

Terraform modules for creating kubernetes master and worker cluster on AWS [EKS](https://aws.amazon.com/eks/).

**Terraform version**: 0.12.23

# List of modules

- [eks_master](eks_master)
- [eks_node_group](eks_node_group)
- [ec2_node_group](ec2_node_group)

#### Post operations

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
    
## Overview

- **Maintainer**: mishalshah92@gmail.com