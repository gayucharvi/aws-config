resource "aws_sns_topic" "config" {
  name = var.topic_name
}


resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.config.arn
  protocol  = "email"
  endpoint  = "praveenpravo08@gmail.com"
}

data "aws_iam_policy_document" "iam_policy" {
  statement {
    effect    = "Allow"
    actions   = ["SNS:Publish"]
    resources = [aws_sns_topic.config.arn]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    Action = "sns:Publish",
      Resource = "arn:aws:sns:region:account-id:myTopic",
        Condition = {
        StringEquals = {
          AWS:SourceAccount = [
           "889796695136",
  ]
}
}
}
}


resource "aws_sns_topic_policy" "topic_policy" {
  arn    = aws_sns_topic.config.arn
  policy = data.aws_iam_policy_document.iam_policy.json
}

