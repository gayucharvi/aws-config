resource "aws_iam_role" "aws-config" {
  name = "my-config"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "aws-config" {
  role       = aws_iam_role.aws-config.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

locals {
  config_name = "Config"
}


resource "aws_config_configuration_recorder" "aws-config" {
  name     = local.config_name
  role_arn = aws_iam_role.aws-config.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "aws-config" {
  name           = local.config_name
  s3_bucket_name = var.bucket_name
  #snapshot_delivery_properties {
  #  delivery_frequency = var.delivery_frequency
  #}
  s3_key_prefix  = var.bucket_key_prefix
  sns_topic_arn  = var.sns_topic_arn


  depends_on = [aws_config_configuration_recorder.aws-config]
}

resource "aws_config_configuration_recorder_status" "aws-config" {
  name       = "${aws_config_configuration_recorder.aws-config.name}"
  is_enabled = true

  depends_on = [aws_config_delivery_channel.aws-config]
}

resource "aws_config_config_rule" "config_rules" {
  for_each = var.config_rules
  name     = each.key
  source {
    owner             = each.value.source.owner
    source_identifier = each.value.source.source_identifier
  }
  scope {
    compliance_resource_types = each.value.scope.compliance_resource_types
  }
  depends_on = [aws_config_configuration_recorder.aws-config]
}

