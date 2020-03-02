resource "signalfx_aws_external_integration" "sfx_integration_external" {
	name = "AWSIntegration-${random_id.suffix.b64_url}"
}

resource "signalfx_aws_integration" "sfx_integration" {
	enabled = var.enabled

	integration_id = signalfx_aws_external_integration.sfx_integration_external.id
	external_id = signalfx_aws_external_integration.sfx_integration_external.external_id
	role_arn = aws_iam_role.sfx_role.arn
	regions = var.aws_regions
	poll_rate = var.aws_poll_rate
	import_cloud_watch = var.import_cloudwatch
	enable_aws_usage = var.import_aws_usage

    
    namespace_sync_rule {
		default_action = var.namespace_rules_default_action
		filter_action = var.namespace_rules_filter_action
		filter_source = var.namespace_rules_filter_source_1
		namespace = var.namespace_rules_1
	}

	dynamic "namespace_sync_rule" {
		iterator = iter
		for_each = var.namespace_rules_list
		content {
			default_action = var.namespace_rules_default_action
			filter_action = var.namespace_rules_filter_action
			filter_source = var.namespace_rules_filter_source
			namespace = iter.value
		}
	}

}
