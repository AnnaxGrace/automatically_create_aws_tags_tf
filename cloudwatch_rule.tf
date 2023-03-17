resource "aws_cloudwatch_event_rule" "auto_tag" {
  name        = var.name
  description = "Automatically tag newly created resources from cloudtrail"

  event_pattern = jsonencode({
  "source": ["aws.s3"],
  "detail-type": ["AWS API Call via CloudTrail"],
  "detail": {
    "eventSource": ["s3.amazonaws.com"]
  }
})
}

#ANNA variabilize arn
resource "aws_cloudwatch_event_target" "auto_tag_lambda" {
  rule      = aws_cloudwatch_event_rule.auto_tag.name

  arn       = "arn:aws:lambda:us-east-1:960206250868:function:automate-tag-create"
}