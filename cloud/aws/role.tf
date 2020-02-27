data "aws_iam_policy_document" "sfx_policy_doc" {
	statement {
		actions = ["sts:AssumeRole"]

		principals {
			type = "AWS"
			identifiers = [signalfx_aws_external_integration.aws_claranet_external.signalfx_aws_account]
		}

		condition {
			test = "StringEquals"
			variable = "sts:ExternalId"
			values = [signalfx_aws_external_integration.aws_claranet_external.external_id]
		}
	}
}

resource "aws_iam_role" "sfx_role" {
	name = "SignalFxAWSIntegrationRole-${random_id.suffix.b64_url}"
	description = "signalfx integration to read out data and send it to signalfxs aws account"
	assume_role_policy = data.aws_iam_policy_document.signalfx_assume_policy.json
}

resource "aws_iam_role_policy_attachment" "sfx_policy_attach" {
	role = aws_iam_role.aws_sfx_role.name
	policy_arn = aws_iam_policy.aws_read_permissions.arn
}
