resource "aws_sns_topic" "config" {
  name = var.topic_name
}


resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.config.arn
  protocol  = "email"
  endpoint  = "praveenpravo08@gmail.com"
}



resource "aws_sns_topic_policy" "topic_policy" {
  arn    = aws_sns_topic.config.arn
  policy = data.aws_iam_policy_document.my_custom_sns_policy_document.json
}

data "aws_iam_policy_document" "my_custom_sns_policy_document" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        ,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.config.arn,
    ]

    sid = "__default_statement_ID"
  }
}

