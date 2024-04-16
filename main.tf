locals {
  json_template = file(".terraform/modules/drata_role_stacksets/drata_cloudformation_stackset_template.json")
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
  parameters    = { ManagementAccountID : var.management_account_id, ExternalID : var.drata_external_id, DrataRoleName : var.role_name }
}

# retrive the organization
data "aws_organizations_organization" "organization" {}

# apply the stack set to the entire organization using the root id
resource "aws_cloudformation_stack_set_instance" "instances" {
  deployment_targets {
    organizational_unit_ids = [data.aws_organizations_organization.organization.roots[0].id]
  }
  region         = var.stackset_region
  stack_set_name = aws_cloudformation_stack_set.stack_set.name
}

# as stacksets doesn't create resources in the management account, another module is used to go forward
module "drata_management_autopilot_role" {
  source                = "git::https://github.com/drata/terraform-aws-drata-autopilot-role.git?ref=${var.release_tag}"
  role_sts_externalid   = var.drata_external_id
  role_name             = var.role_name
  drata_aws_account_arn = "arn:aws:iam::${var.management_account_id}:root"
}
