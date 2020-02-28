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
