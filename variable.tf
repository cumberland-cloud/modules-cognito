variable "cognito" {
    description             = "Cognito configuration object"
    type                    = object({
        access_group        = object({
            name            = string
            role_arn        = string
        })
        user_pool_name      = string
        user_schema         = optional(
            list(
                object({
                    mutable     = bool
                    name        = string
                })
            ), 
            [{
                mutable         = true
                name            = "email"
            },{
                mutable         = true
                name            = "username"
            }]
        )

    })
}

variable "domain" {
    description             = "Fully qualified domain name"
    type                    = string
}