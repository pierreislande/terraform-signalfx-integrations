# ALERTING PAGERDUTY SignalFx integrations

## How to use this module

```hcl
module "signalfx-integrations-alerting-pagerduty" {
  source      = "github.com/claranet/terraform-signalfx-integrations.git//alerting/pagerduty"

  api_key    = var.api_key
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| api\_key | Pagerduty API token | `any` | n/a | yes |
| enabled | Whether the PagerDuty integration is enabled | `string` | `"true"` | no |
| suffix | Optional suffix to identify and avoid duplication of unique resources | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| sfx\_integration\_id | SignalFx integration ID |

## Related documentation

[Official documentation](https://docs.signalfx.com/en/latest/admin-guide/integrate-notifications.html#integrate-with-pagerduty)
[Pagerduty documentation](https://www.pagerduty.com/docs/guides/signalfx-integration-guide/)
