resource "aws_iam_role" "tenant_roles" {
    for_each            = local.tenant_roles
    
    name                = each.value.name
    assume_role_policy  = data.aws_iam_policy_document.tenant_assume_role.json
}

resource "aws_iam_role_policy_attachment" "tenant_role_attachments" {
    for_each            = local.tenant_attachment_map

    role                = aws_iam_role.tenant_roles[each.value.role_key].name
    policy_arn          = each.value.policy_arn
}