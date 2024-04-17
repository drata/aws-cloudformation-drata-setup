# get the organization info
data "aws_organizations_organization" "organization" {}

locals {
  json_template         = file(".terraform/modules/drata_role_stacksets/drata_cloudformation_stackset_template.json")
  management_account_id = data.aws_organizations_organization.organization.master_account_id
}

# define the stack set
# this contains the role creation template
resource "aws_cloudformation_stack_set" "stack_set" {
  name             = "drata-role-terraform-stack-set"
  permission_model = "SERVICE_MANAGED"
  capabilities     = ["CAPABILITY_NAMED_IAM"]
  auto_deployment {
    enabled = true
  }
  operation_preferences {
    failure_tolerance_count = 0
    max_concurrent_count    = 3
  }
  template_body = local.json_template
  parameters    = { ManagementAccountID : local.management_account_id, ExternalID : var.drata_external_id }
}

# apply the stack set to the entire organization using the root id
resource "aws_cloudformation_stack_set_instance" "instances" {
  deployment_targets {
    organizational_unit_ids = [data.aws_organizations_organization.organization.roots[0].id]
  }
  region         = var.stackset_region
  stack_set_name = aws_cloudformation_stack_set.stack_set.name
}
