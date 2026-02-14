output "user_pool_id" {
  description = "Cognito User Pool ID"
  value       = aws_cognito_user_pool.main.id
}

output "user_pool_arn" {
  description = "Cognito User Pool ARN"
  value       = aws_cognito_user_pool.main.arn
}

output "app_client_id" {
  description = "Backend App Client ID"
  value       = aws_cognito_user_pool_client.backend.id
}

output "app_client_secret" {
  description = "Backend App Client Secret"
  value       = aws_cognito_user_pool_client.backend.client_secret
  sensitive   = true
}

output "domain" {
  description = "Cognito hosted UI domain"
  value       = "${aws_cognito_user_pool_domain.main.domain}.auth.${data.aws_region.current.name}.amazoncognito.com"
}

output "user_pool_endpoint" {
  description = "Cognito User Pool endpoint (OIDC issuer base URL)"
  value       = "https://${aws_cognito_user_pool.main.endpoint}"
}
