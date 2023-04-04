resource "aws_iam_policy" "auto_tag_lambda" {
  name        = "${var.name}-lambda"
  description = "Policy that allows lambda to auto create tags for newly created resources"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "CloudWatchMetrics",
        "Effect" : "Allow",
        "Action" : [
          "cloudwatch:PutMetricData",
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "GlobalPermissions",
        "Effect" : "Allow",
        "Action" : [
          "logs:DescribeLogGroups",
          "iam:ListRoleTags",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents"
        ],
        "Resource" : [
          "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.name}",
          "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.name}:log-stream:*",
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"
        ]
      },
      {
        "Sid" : "s3Tagging",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutBucketTagging",
          "s3:GetBucketTagging"
        ],
        "Resource" : [
          "arn:aws:s3:::*"
        ]
      }
    ]
  })

  tags = merge(
    {
      "Name" = format("%s-IAM-policy", var.name)
    },
    var.global_tags, 
    local.variable_global_tags
  )
}
