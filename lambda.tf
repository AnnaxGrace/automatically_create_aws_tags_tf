data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "lambda_tag_resources.py"
  output_path = "lambda_tag_resources.zip"
}

module "lambda_auto_tag" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 2.0"

  function_name = var.name
  handler       = "lambda_tag_resources.tag_resources"
  runtime       = "python3.9"
  attach_policy = true
  policy        = aws_iam_policy.auto_tag_lambda.arn

  create_package         = false
  local_existing_package = "lambda_tag_resources.zip"

  create_current_version_allowed_triggers = false
  allowed_triggers = {
    ScanAmiRule = {
      principal  = "events.amazonaws.com"
      source_arn = aws_cloudwatch_event_rule.auto_tag.arn
    }
  }

  tags = merge(
    {
      "Name" = format("%s-lambda", var.name)
    },
    var.global_tags, 
    local.variable_global_tags
  )
}
