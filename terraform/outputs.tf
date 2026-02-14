output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value       = module.cognito.user_pool_id
}

output "cognito_user_pool_arn" {
  description = "Cognito User Pool ARN"
  value       = module.cognito.user_pool_arn
}

output "cognito_app_client_id" {
  description = "Cognito Backend App Client ID"
  value       = module.cognito.app_client_id
}

output "cognito_app_client_secret" {
  description = "Cognito Backend App Client Secret"
  value       = module.cognito.app_client_secret
  sensitive   = true
}

output "cognito_domain" {
  description = "Cognito hosted UI domain"
  value       = module.cognito.domain
}

output "cognito_user_pool_endpoint" {
  description = "Cognito User Pool OIDC issuer endpoint"
  value       = module.cognito.user_pool_endpoint
}
