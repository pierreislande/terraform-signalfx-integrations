data "google_service_account" "sfx_service_account" {
  count      = var.gcp_service_account_id != "" ? 1 : 0
  account_id = var.gcp_service_account_id
}

resource "google_service_account" "sfx_service_account" {
  count        = var.gcp_service_account_id == "" ? 1 : 0
  account_id   = "signalfx-integration${var.suffix == "" ? "" : "-${lower(var.suffix)}"}"
  display_name = "SignalFX integration${var.suffix == "" ? "" : " - ${title(var.suffix)}"}"
}

locals {
  id_to_use = length(data.google_service_account.sfx_service_account) > 0 ? data.google_service_account.sfx_service_account[0].id : google_service_account.sfx_service_account[0].id
}

resource "google_service_account_key" "sak" {
  service_account_id = local.id_to_use
}

resource "google_project_iam_custom_role" "sfx_role" {
  role_id     = "signalfx${var.suffix == "" ? "" : ".${lower(var.suffix)}"}"
  title       = "SignalFX${var.suffix == "" ? "" : " - ${title(var.suffix)}"}"
  description = "SignalFX viewer role for monitoring${var.suffix == "" ? "" : " for ${lower(var.suffix)}"}"
  permissions = [
    "monitoring.metricDescriptors.get",
    "monitoring.metricDescriptors.list",
    "monitoring.timeSeries.list",
    "resourcemanager.projects.get",
    "compute.instances.list",
    "compute.machineTypes.list",
    "spanner.instances.list",
    "storage.buckets.list",
  ]
}

resource "google_project_iam_member" "sfx_service_account_membership" {
  project = var.gcp_project_id
  role    = "projects/${var.gcp_project_id}/roles/${google_project_iam_custom_role.sfx_role.role_id}"
  member  = "serviceAccount:${google_service_account.sfx_service_account[0].email}"
}

resource "signalfx_gcp_integration" "gcp_claranet_integration" {
  name      = "GCPIntegration${var.suffix == "" ? "" : "-${title(var.suffix)}"}"
  enabled   = var.enabled
  poll_rate = var.poll_rate
  project_service_keys {
    project_id  = var.gcp_project_id
    project_key = base64decode(google_service_account_key.sak.private_key)
  }

  depends_on = [google_project_iam_member.sfx_service_account_membership]
}
