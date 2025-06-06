# IBM Cloud IKS Classic Terraform Configuration

This repository contains Terraform modules and Kubernetes manifests for a non-production IBM Cloud Kubernetes Service (IKS) cluster running on Classic infrastructure. Key components include:

- **IKS Cluster** (`iks.tf`)
  - Terraform definitions for provisioning a single-zone cluster with public and private VLANs.
  - Parameters for region, hardware type, worker pools, and Kubernetes version.
- **Cloud Object Storage** (`cos.tf`)
  - Terraform resources to create a Cloud Object Storage instance and bucket for testing purposes.
- **Kubernetes Manifests** (`kube/`)
  - Example manifests deploying MySQL and MariaDB databases along with a phpMyAdmin console for non-production use.
- **Tekton Pipeline** (`.tekton/pipeline.yaml`)
  - Demonstrates a simple build-and-deploy pipeline that containerizes an application and deploys it to the IKS cluster using Tekton tasks.

These examples are intended for learning and experimentation and should not be used as-is for production workloads.
