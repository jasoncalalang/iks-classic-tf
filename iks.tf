terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.50"
    }
  }
  required_version = ">= 1.3.0"
}

provider "ibm" {
  ibmcloud_api_key      = var.ibmcloud_api_key
  region                = var.region
  iaas_classic_username = var.iaas_classic_username
  iaas_classic_api_key  = var.iaas_classic_api_key
}
variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key"
  type        = string
  sensitive   = true
}

variable "iaas_classic_username" {
  description = "IBM Cloud Classic Infrastructure Username"
  type        = string
  sensitive   = true
}

variable "iaas_classic_api_key" {
  description = "IBM Cloud Classic Infrastructure API Key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "IBM Cloud region"
  type        = string
  default     = "jp-tok"
}

variable "cluster_name" {
  description = "Name of the IKS cluster"
  type        = string
  default     = "test-iks-01"
}

variable "zones" {
  description = "List of datacenters (zones)"
  type        = list(string)
  default     = ["tok02", "tok04"]
}

variable "machine_type" {
  description = "Machine type for worker nodes"
  type        = string
  default     = "b3c.4x16"
}

variable "hardware" {
  description = "Hardware type: 'shared' or 'dedicated'"
  type        = string
  default     = "shared"
}

variable "public_vlan_id" {
  description = "Public VLAN ID in the specified datacenter"
  type        = string
}

variable "private_vlan_id" {
  description = "Private VLAN ID in the specified datacenter"
  type        = string
}

variable "default_pool_size" {
  description = "Number of worker nodes in the default pool"
  type        = number
  default     = 3
}

variable "kube_version" {
  description = "Kubernetes version for the cluster"
  type        = string
  default     = "1.32.4"
}

resource "ibm_container_cluster" "classic_cluster" {
  name                    = var.cluster_name
  machine_type            = var.machine_type
  hardware                = var.hardware
  public_vlan_id          = var.public_vlan_id
  private_vlan_id         = var.private_vlan_id
  default_pool_size       = var.default_pool_size
  kube_version            = var.kube_version
  public_service_endpoint = true
  private_service_endpoint = true
  datacenter              = var.zones[0]
  tags                   = ["prod"]
}

resource "ibm_container_cluster" "iks_nonprod" {
  name                    = "test-nonprod-classic"
  machine_type            = "m3c.8x64"
  hardware                = var.hardware
  public_vlan_id          = var.public_vlan_id
  private_vlan_id         = var.private_vlan_id
  default_pool_size       = 1
  kube_version            = var.kube_version
  public_service_endpoint = true
  private_service_endpoint = true
  datacenter              = var.zones[0]
  tags                    = ["nonprod", "test"]
}
