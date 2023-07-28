resource "aws_cognito_user_pool" "this" {
    name                                    = var.cognito.user_pool_name

    admin_create_user_config {
        allow_admin_create_user_only        = true
    }
  
    password_policy {
        minimum_length                      = 12
        require_lowercase                   = true
        require_symbols                     = true 
        require_uppercase                   = true
        temporary_password_validity_days    = 3  
    }

    username_configuration {
        case_sensitive                      = true
    }

    dynamic "schema" {
        for_each                            = toset(var.cognito.user_schema)
        
        content{
            name                            = schema.name
            attribute_data_type             = "String"
            developer_only_attribute        = false
            mutable                         = schema.mutable 
            required                        = true
        }
    }
}

resource "aws_cognito_user_pool_client" "this" {
    access_token_validity                   = 60
    allowed_oauth_flows                     = [ "implicit" ]
    allowed_oauth_scopes                    = [ 
        "email", 
        "openid", 
        "profile" 
    ]
    allowed_oauth_flows_user_pool_client    = true
    callback_urls                           = [ "http://${var.domain}"]
    explicit_auth_flows                     = [
        "ALLOW_CUSTOM_AUTH",
        "ALLOW_REFRESH_TOKEN_AUTH",
        "ALLOW_USER_PASSWORD_AUTH",
        "ALLOW_USER_SRP_AUTH"
    ]
    id_token_validity                       = 60
    name                                    = "${var.cognito.user_pool_name}-client"
    refresh_token_validity                  = 30
    supported_identity_providers            = [ "COGNITO" ]
    user_pool_id                            = aws_cognito_user_pool.this.id

    token_validity_units {
        access_token                        = "minutes"
        id_token                            = "minutes"
        refresh_token                       = "days"
    }
}

resource "aws_cognito_user_group" "this" {
    description                             = "Cognito ${title(var.cognito.access_group.name)} Access Group"
    name                                    = var.cognito.access_group.name
    role_arn                                = var.cognito.access_group.role_arn
    user_pool_id                            = aws_cognito_user_pool.this.id
}