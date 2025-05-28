###############################################################################
# IBM Container Registry – non-prod
###############################################################################

variable "icr_instance_name" {
  type    = string
  default = "da-nonprod"
}

resource "ibm_cr_namespace" "icr_namespace" {
  name               = var.icr_instance_name 
  resource_group_id  = data.ibm_resource_group.target.id
  tags               = ["nonprod", "icr", "terraform"]
}
