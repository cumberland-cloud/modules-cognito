variable "cognito" {
    description             = "Cognito configuration object"
    type                    = object({
        user_pool_name      = string
        access_group        = object({
            name            = string
            role_arn        = string
        })
    })
}

variable "domain" {
    description             = "Fully qualified domain name"
    type                    = string
}