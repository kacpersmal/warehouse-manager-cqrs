variable "project_name" {
  description = "Project identifier used in resource names"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "password_minimum_length" {
  description = "Minimum password length"
  type        = number
  default     = 12
}

variable "temporary_password_validity_days" {
  description = "Number of days a temporary password is valid"
  type        = number
  default     = 7
}

variable "deletion_protection" {
  description = "Deletion protection for the user pool (ACTIVE or INACTIVE)"
  type        = string
  default     = "INACTIVE"
}
