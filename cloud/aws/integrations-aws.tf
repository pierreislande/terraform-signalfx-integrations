resource "signalfx_aws_external_integration" "aws_claranet_external" {
	name = "AWSClaranetIntegration"
}

resource "signalfx_aws_integration" "aws_claranet" {
	enabled = var.enabled

	integration_id = signalfx_aws_external_integration.aws_claranet_external.id
	external_id = signalfx_aws_external_integration.aws_claranet_external.external_id
	role_arn = aws_iam_role.aws_sfx_role.arn
	regions = var.aws_regions
	poll_rate = var.poll_rate
	import_cloud_watch = var.import_cloudwatch
	enable_aws_usage = var.import_aws_usage

	/*custom_namespace_sync_rule {
		default_action = var.custom_namespace_rules_default_action
		filter_action = var.custom_namespace_rules_filter_action
		filter_source = var.custom_namespace_rules_filter_source
		namespace = var.custom_namespace_rules_namespace
	}

	namespace_sync_rule {
		default_action = var.namespace_rules_default_action
		filter_action = var.namespace_rules_filter_action
		filter_source = var.namespace_rules_filter_source
		namespace = var.namespace_rules_namespace
	}*/
}
