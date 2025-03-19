variable "project_name" {
  type        = string
  description = "Project name"
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

data "aws_caller_identity" "current" {}