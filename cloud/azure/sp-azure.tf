resource "azuread_application" "signalfx_integration" {
  name     = "SignalFxAzureIntegration"
  homepage = "https://www.signalfx.com/"

  available_to_other_tenants = false
  oauth2_allow_implicit_flow = false
}

resource "azuread_service_principal" "signalfx_integration_sp" {
  application_id               = azuread_application.signalfx_integration.application_id
  app_role_assignment_required = false
}

resource "random_password" "signalfx_integration_password" {
  length  = 32
  special = true
  #  override_special = "_%@"
}

resource "azuread_service_principal_password" "signalfx_integration_sp_pwd" {
  service_principal_id = azuread_service_principal.signalfx_integration_sp.id
  value                = random_password.signalfx_integration_password.result
  #  end_date             = "2020-01-01T01:02:03Z"
}

resource "azurerm_role_assignment" "signalfx_integration_sp_reader" {
  for_each = toset(var.azure_subscription_ids)

  scope                = format("/subscriptions/%s", each.key)
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.signalfx_integration_sp.object_id
}
