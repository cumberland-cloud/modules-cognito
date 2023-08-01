data "aws_iam_policy_document" "tenant_assume_role" {
    statement {
        sid                 = "TenantTrustRelationship"
        effect              = "Allow"
        actions             = [ "sts:AssumeRoleWithWebIdentity" ]

        principals {
            type            = "Federated"
            identifiers     = [ "cognito-identity.amazonaws.com" ]
        }
        
        condition {
            test                = "StringEquals"
            variable            = "cognito-identity.amazonaws.com:aud"
            values              = [
                aws_cognito_user_pool.this.id
            ]
        }
    }
}