# k8s-eks-terraform-modules

## Introduction

Terraform modules for creating kubernetes master and worker cluster on AWS [EKS](https://aws.amazon.com/eks/)

**Terraform version**: 0.12.23

## How to use?
- EKS Master: See [example](test/eks_master/main.tf)
- EKS Node Group: See [example](test/eks_node-group/main.tf)
- EC2 Node Group: See [example](test/ec2_node_groups/main.tf)

### Developing

```shell script
$ make [Target]
```

### **Targets**

- `$ make deploy-master`

    It will create the EKS cluster.
 
- `$ make destroy-master`

    It will destroy the EKS cluster.    

- `$ make deploy-ec2-nodes`

    It will create the EC2 node group for EKS cluster.
 
- `$ make destroy-ec2-nodes`

    It will destroy EC2 node group for EKS cluster.

- `$ make deploy-eks-nodes`

    It will create the EKS node group for EKS cluster.
 
- `$ make destroy-eks-nodes`

    It will destroy EKS node group for EKS cluster.

#### Update local Kubernetes config
```shell script
$ aws eks --region {aws_region} update-kubeconfig --name {cluster_name}
```

#### Apply Kubernetes config.
```shell script
$ kubectl apply -f config_map_aws_auth.yaml
```

#### To view nodes
```shell script
$ kubectl get nodes --watch
```
    
## Overview

- **Maintainer**: mishalshah92@gmail.com