# Global

variable "suffix" {
  description = "Optional suffix to identify and avoid duplication of unique resources"
  type        = string
  default     = ""
}

# Azure Integration specific

variable "enabled" {
  description = "Whether the Azure integration is enabled"
  type        = bool
  default     = true
}

variable "poll_rate" {
  description = "AWS poll rate in seconds (60 or 300)"
  default     = 300
}

variable "sfx_integration_name_suffix" {
  description = "SignalFx Integration name suffix"
  type        = string
  default     = ""
}

variable "custom_sfx_integration_name" {
  description = "SignalFx integration custom resource name"
  type        = string
  default     = ""
}

# Azure Resources Parameters
variable "azure_tenant_id" {
  description = "Azure Tenant ID/Directory ID"
  type        = string
}

variable "azure_subscription_ids" {
  description = "List of Azure Subscription IDs to monitor"
  type        = list(string)
}

variable "azure_sp_validation_time" {
  description = <<EOD
  Relative duration for which the Password is valid until, for example `240h` (10 days) or `2400h30m`. Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h".
  Changing this field forces a new resource to be created
EOD
  type        = string
  default     = "${2 * 365 * 24}h" # approximately 2 years
}
