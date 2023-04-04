<br/>

<img src="./SQL/DOCS/images/TEKsystems_brandmark_CMYK.png"
     alt="Teksystems brandmark"
     style="margin-right: 10px; height: 50px;" />

<br/>

# Automatically Create AWS Tags Using AWS Lambda

## Description
This is a Terraform script that automatically adds tags for manually created resources 

## Table of Contents
* [Requirements](#requirements)
* [Providers](#providers)
* [Modules](*modules)
* [Inputs](#inputs)
* [Outputs](#outputs)
* [Installation](#installation)
* [Usage](#usage)
* [License](#license)
* [Contributing](#contributing)


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.3.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.59.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_auto_tag"></a> [lambda\_auto\_tag](#module\_lambda\_auto\_tag) | terraform-aws-modules/lambda/aws | ~> 2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.automatic_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_cloudwatch_event_rule.auto_tag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.auto_tag_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.auto_tag_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_s3_bucket.cloudtrail_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.cloudtrail_bucket_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [archive_file.lambda_code](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cloudtrail_bucket_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Enter a profile name to deploy infrastructure into | `string` | `"anna-account"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Enter a region id to deploy infrastruction into | `string` | `"us-east-1"` | no |
| <a name="input_editor"></a> [editor](#input\_editor) | Enter the email ID of the person who is creating/editing this infrastructure. | `string` | `"aconover@teksystems.com"` | no |
| <a name="input_global_tags"></a> [global\_tags](#input\_global\_tags) | Application specific tags. | `map(any)` | <pre>{<br>  "terraform_created": true<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | The name you would like to prefix your resources | `string` | `"auto-tag-creation"` | no |


## Installation
Needed to run:

Terraform: [download version .12 and above](https://www.terraform.io/downloads)

## Usage

terraform init 
terraform apply

Will create
    - IAM Policy
    - Cloudtrail
    - Cloudwatch rule
    - Lambda

S3 buckets created after this code is provisioned will have the tag "last_edited_by" with the username as the value.

## License
© 2022 TEKsystems Global Services, LLC ALL RIGHTS RESERVED.

## Contributing
No outside contributors allowed.
