locals {
    formatted_namespace                     = lower(replace(replace(var.namespace, "/", "-"), "_", "-"))
    tenant_attachments                      = flatten([
        for role_key, role in local.tenant_roles: [
            for policy_key, policy_arn in role.attachments: {
                role_key                    = role_key
                policy_arn                  = policy_arn
            }
        ]
    ])
    tenant_attachment_map                   = {
        for index, attachment in local.tenant_attachments:
            index                           => attachment
    }
    tenant_roles                            = {
        tenant_user                         = {
            name                            = "${var.namespace}-tenant-user"
        }
        tenant_admin                        = {
            name                            = "${var.namespace}-tenant-admin"
        }
    }
}
