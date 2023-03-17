# Global Variables ------------------------------------------------

variable "aws_region" {
  description = "Enter a region id to deploy infrastruction into"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Enter a profile name to deploy infrastructure into"
  default     = "anna-account"
}

variable "name" {
  description = "The name you would like to prefix your resources"
  default     = "auto-tag-creation"
}

variable "app_tags" {
  description = "Application specific tags."
  type        = map(any)
  default     = { "pod" = "platform agility" }
}

# variable "editor" {
#   description = "Enter the email ID of the person who is creating/editing this infrastructure."
#   type        = string
# }

variable "editor" {
  description = "Enter the email ID of the person who is creating/editing this infrastructure."
  type        = string
  default     = "aconover@teksystems.com"
}
