data "aws_iam_policy_document" "tenant_assume_role" {
    statement {
        sid                 = "TenantTrustRelationship"
        effect              = "Allow"
        actions             = [ "sts:AssumeRole" ]

        condition {
            test                = "StringEquals"
            variable            = "cognito-identity.amazonaws.com:aud"
            values              = [
                aws_cognito_user_group.this.user_pool_id
            ]
        }
    }
}