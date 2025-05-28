###############################################################################
# Cloud Object Storage – non-prod
###############################################################################
variable "resource_group" {
  description = "Target resource group name or ID"
  type        = string
  default     = "Default"
}

variable "object_storage_name" {
  type = string
}

variable "bucket_name" {
  type = string
}

data "ibm_resource_group" "target" {
  name = var.resource_group  # already defined in your code
}

resource "ibm_resource_instance" "cos_nonprod" {
  name              = var.object_storage_name
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"               
  resource_group_id = data.ibm_resource_group.target.id
  tags              = ["nonprod", "storage", "terraform"]
}

resource "ibm_cos_bucket" "bucket_nonprod" {
  bucket_name          = var.bucket_name
  resource_instance_id = ibm_resource_instance.cos_nonprod.id
  region_location      = var.region
  storage_class        = "standard"
  endpoint_type        = "public"
  force_delete         = true
}
