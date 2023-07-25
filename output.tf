ouput "user_pool" {
    value               = {
        id              = aws_cognito_user_pool.this.id
        arn             = aws_cognito_user_pool.this.arn
        endpoint        = aws_cognito_user_pool.this.endpoint
        client_id       = aws_cognito_user_pool_client.this.id
    }
}