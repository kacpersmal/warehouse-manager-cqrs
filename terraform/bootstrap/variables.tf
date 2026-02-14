variable "project_name" {
  description = "Project identifier used in resource names"
  type        = string
  default     = "warehouse-manager"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
