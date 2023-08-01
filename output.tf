output "user_pool" {
    description         = "Object containing the metadata for the provisioned Cognito User Pool, including the associated client."
    value               = {
        id              = aws_cognito_user_pool.this.id
        arn             = aws_cognito_user_pool.this.arn
        endpoint        = aws_cognito_user_pool.this.endpoint
        client_id       = aws_cognito_user_pool_client.this.id
        group_ids       = aws_cognito_user_group.this[*].user_pool_id
    }
}

output "user_roles" {
    description         = "Map of IAM roles mapped to user groups."
    value               = { 
        for role_key, role in aws_iam_role.tenant_roles:
            role_key    => {
                arn     = role.arn
                id      = role.id
                name    = role.name   
            }
    }
}