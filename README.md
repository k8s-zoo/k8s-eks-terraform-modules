# k8s-eks-terraform-modules

## Introduction

Terraform modules for creating kubernetes master and worker cluster on AWS [EKS](https://aws.amazon.com/eks/)

**Terraform version**: 0.12.23

## How to use?
See [example](test/main.tf).

## How to import?

```shell script
$ aws eks --region {aws_region} update-kubeconfig --name {eks_cluster_name}
$ kubectl apply -f config_map_aws_auth.yaml
$ kubectl get nodes --watch
```
    
## Overview

- **Maintainer**: mishalshah92@gmail.com