resource "signalfx_azure_integration" "azure_integration" {
  name        = coalesce(var.custom_sfx_integration_name, local.default_integration_name)
  enabled     = var.enabled
  environment = "azure"

  poll_rate = var.poll_rate

  secret_key = random_password.signalfx_integration_password.result
  app_id     = azuread_application.signalfx_integration.application_id

  services = [] # empty = All

  tenant_id     = var.azure_tenant_id
  subscriptions = var.azure_subscription_ids
}
