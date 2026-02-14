locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

data "aws_region" "current" {}

# ──────────────────────────────────────────────
# User Pool
# ──────────────────────────────────────────────

resource "aws_cognito_user_pool" "main" {
  name = "${local.name_prefix}-user-pool"

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Your ${var.project_name} verification code"
    email_message        = "Your verification code is {####}"
  }

  password_policy {
    minimum_length                   = var.password_minimum_length
    require_lowercase                = true
    require_uppercase                = true
    require_numbers                  = true
    require_symbols                  = true
    temporary_password_validity_days = var.temporary_password_validity_days
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  schema {
    attribute_data_type      = "String"
    name                     = "email"
    required                 = true
    mutable                  = true

    string_attribute_constraints {
      min_length = 5
      max_length = 254
    }
  }

  deletion_protection = var.deletion_protection

  tags = {
    Name = "${local.name_prefix}-user-pool"
  }
}

# ──────────────────────────────────────────────
# User Pool Domain (hosted UI / OAuth2 endpoints)
# ──────────────────────────────────────────────

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "${local.name_prefix}-auth"
  user_pool_id = aws_cognito_user_pool.main.id
}

# ──────────────────────────────────────────────
# App Client (backend server)
# ──────────────────────────────────────────────

resource "aws_cognito_user_pool_client" "backend" {
  name         = "${local.name_prefix}-backend-client"
  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret = true

  access_token_validity  = 1
  id_token_validity      = 1
  refresh_token_validity = 30

  token_validity_units {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "days"
  }

  prevent_user_existence_errors = "ENABLED"

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
  ]
}
