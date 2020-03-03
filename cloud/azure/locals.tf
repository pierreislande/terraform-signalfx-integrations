locals {
  sfx_suffix               = var.sfx_integration_name_suffix == "" ? "" : format("-%s", var.sfx_integration_name_suffix)
  default_integration_name = format("AzureClaranetIntegration%s", local.sfx_suffix)
}
