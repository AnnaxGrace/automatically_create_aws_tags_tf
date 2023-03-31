resource "aws_cloudwatch_event_rule" "auto_tag" {
  name        = var.name
  description = "Automatically tag newly created resources from cloudtrail"

  event_pattern = jsonencode({
    "source" : ["aws.s3"],
    "detail-type" : ["AWS API Call via CloudTrail"],
    "detail" : {
      "eventSource" : ["s3.amazonaws.com"]
    }
  })

 tags = merge(
    {
      "Name" = format("%s-cloudwatch-rule", var.name)
    },
    var.global_tags, 
    local.variable_global_tags
  )
}

resource "aws_cloudwatch_event_target" "auto_tag_lambda" {
  rule = aws_cloudwatch_event_rule.auto_tag.name
  arn  = "arn:aws:lambda:${var.aws_region}:${data.aws_caller_identity.current.account_id}:function:${var.name}"
}
