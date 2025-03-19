variable "project_name" {
  type        = string
  description = "Project name"
}

variable "container_name" {
  type        = string
  description = "Name of the container"
}

variable "container_image" {
  type        = string
  description = "Image for the ECS container"
}

variable "execution_role_arn" {
  type        = string
  description = "ARN of the ECS execution role"
}

variable "task_role_arn" {
  type        = string
  description = "ARN of the ECS task role"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnets"
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where ECS is deployed"
}
