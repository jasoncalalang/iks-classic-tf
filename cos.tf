###############################################################################
# Cloud Object Storage – non-prod
###############################################################################
variable "resource_group" {
  description = "Target resource group name or ID"
  type        = string
  default     = "Default"
}

data "ibm_resource_group" "target" {
  name = var.resource_group  # already defined in your code
}

resource "ibm_resource_instance" "cos_nonprod" {
  name              = "cos-nonprod"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"                 # <-- only valid location
  resource_group_id = data.ibm_resource_group.target.id
  tags              = ["nonprod", "storage", "terraform"]
}

resource "ibm_cos_bucket" "bucket_nonprod" {
  bucket_name          = "testjasonnonprod"    # must stay globally unique
  resource_instance_id = ibm_resource_instance.cos_nonprod.id
  region_location      = "jp-tok"              # keeps data in TOK
  storage_class        = "standard"
  endpoint_type        = "public"
  force_delete         = true
}
