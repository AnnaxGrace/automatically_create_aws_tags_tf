# resource "aws_iam_policy" "auto_tag_lambda" {
#   name        = "${var.name}-lambda"
#   description = "Policy that allows lambda to auto create tags for newly created resources"

#   #ANNA variabilize this policy
#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Sid" : "VisualEditor0",
#         "Effect" : "Allow",
#         "Action" : [
#           "cloudwatch:PutMetricData",
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Sid" : "VisualEditor1",
#         "Effect" : "Allow",
#         "Action" : [
#           "logs:DescribeLogGroups",
#           "iam:ListRoleTags",
#           "logs:DescribeLogStreams",
#           "logs:GetLogEvents",
#           "ssm:GetParametersByPath"
#         ],
#         "Resource" : [
#           "arn:aws:ssm:*:960206250868:parameter/*",
#           "arn:aws:logs:us-east-1:960206250868:log-group:/aws/lambda/automate-tag-create",
#           "arn:aws:logs:us-east-1:960206250868:log-group:/aws/lambda/automate-tag-create:log-stream:*",
#           "arn:aws:iam::960206250868:role/*"
#         ]
#       },
#       {
#         "Sid" : "VisualEditor2",
#         "Effect" : "Allow",
#         "Action" : [
#           "logs:CreateLogStream",
#           "s3:PutBucketTagging",
#           "s3:GetBucketTagging",
#           "logs:CreateLogGroup",
#           "logs:PutLogEvents"
#         ],
#         "Resource" : [
#           "arn:aws:s3:::*",
#           "arn:aws:logs:us-east-1:960206250868:log-group:/aws/lambda/automate-tag-create",
#           "arn:aws:logs:us-east-1:960206250868:log-group:/aws/lambda/automate-tag-create:log-stream:*"
#         ]
#       }
#     ]
#   })
# }

# resource "aws_iam_role" "auto_tag_lambda" {
#   name = "${var.name}-lambda"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Effect" : "Allow",
#         "Principal" : {
#           "Service" : "lambda.amazonaws.com"
#         },
#         "Action" : "sts:AssumeRole"
#       }
#     ]
#   })

#   tags = app_tags
# }

# resource "aws_iam_role_policy_attachment" "auto_tag_lambda" {
#   role       = aws_iam_role.auto_tag_lambda.name
#   policy_arn = aws_iam_policy.auto_tag_lambda.arn
# }