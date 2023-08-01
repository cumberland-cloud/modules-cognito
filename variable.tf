variable "cognito" {
    description             = "Cognito configuration object"
    type                    = object({
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
                name            = "name"
            }]
        )

    })
}

variable "domain" {
    description             = "Fully qualified domain name"
    type                    = string
}

variable "namespace" {
    description             = "Namespace of the Cognito resources"
    type                    = string
}