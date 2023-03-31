terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

data "aws_caller_identity" "current" {}

locals {
  variable_global_tags = {
    "date_edited" = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
    "last_edited_by" = var.editor
  }
}
# create a service account for this

#anna add tags to all