resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket        = "${var.name}-cloudtrail-logs"
  force_destroy = true

  tags = merge(
    {
      "Name" = format("%s-cloudtrail", var.name)
    },
    var.global_tags, 
    local.variable_global_tags
  )
}

data "aws_iam_policy_document" "cloudtrail_bucket_access" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.cloudtrail_logs.arn]
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.cloudtrail_logs.arn}/s3_tags/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudtrail_bucket_access" {
  bucket = aws_s3_bucket.cloudtrail_logs.id
  policy = data.aws_iam_policy_document.cloudtrail_bucket_access.json
}

resource "aws_cloudtrail" "automatic_logging" {
  name                          = var.name
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs.id
  s3_key_prefix                 = "s3_tags"
  include_global_service_events = false

  tags = merge(
    {
      "Name" = format("%s-cloudtrail", var.name)
    },
    {
      "last_edited_by" = var.editor
    },
    var.global_tags
  )
}
