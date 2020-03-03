# Azure Integration specific
variable "enabled" {
  description = "Flag that controls whether the integration is enabled"
  type        = bool
  default     = true
}

variable "poll_rate" {
  description = "Poll rate (in seconds). One of 60 or 300."
  type        = number
  default     = 60
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
  default     = "17500h" # 2 years
}
