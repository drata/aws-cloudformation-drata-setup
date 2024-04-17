# aws-cloudformation-drata-setup

AWS Cloudformation terraform script to create the Drata Autopilot role across an Organizational Unit.

## Example Usage

The example below uses `ref=main` (which is appended in the URL),  but it is recommended to use a specific tag version (i.e. `ref=1.0.0`) to avoid breaking changes. Go to the [release page](https://github.com/drata/aws-cloudformation-drata-setup/releases) for a list of published versions.

Replace `YOUR_EXTERNAL_ID` with the external id given by the UI. i.e. `00000000-0000-0000-0000-000000000000`.
Replace `YOUR_MANAGEMENT_ACCOUNT_ID` with the AWS management account. i.e. `012345678912`.

```
module "drata_role_cloudformation_stacksets" {
    source = "git::https://github.com/drata/aws-cloudformation-drata-setup.git?ref=main"
    drata_external_id = "YOUR_EXTERNAL_ID"
    management_account_id = "YOUR_MANAGEMENT_ACCOUNT_ID"
    # stackset_region = "REGION" # If it's unset the default value is 'us-west-2'
}
```

## Setup

The following steps will guide you on how to run this script.

1. Add the code above to your terraform code.
2. Replace `main` in `ref=main` with the latest version from the [release page](https://github.com/drata/aws-cloudformation-drata-setup/releases).
3. In your browser, open https://app.drata.com/account-settings/connections/aws-org-units.
4. Copy the `Drata External ID` from the AWS Org Units connection panel in Drata and replace `YOUR_EXTERNAL_ID` in the module with the ID you copied.
5. Go to the AWS console, get the `Management Account Id` and replace `YOUR_MANAGEMENT_ACCOUNT_ID`.
6. Replace `stackset_region` if the desired region is different than the default value `us-west-2`.
7. The role name can be customized by setting the `drata_role_name` variable. Recommend to use `DrataAutopilotRole`.
8. Back in your terminal, run terraform init to download/update the module.
9. Run terraform apply and **IMPORTANT** review the plan output before typing yes.
10. If successful, go back to the AWS console and verify the Role has been generated in all the accounts.
11. If you'd want to roll back the operations this script just performed, type `terraform destroy` and `enter`.

## Disclaimer

AWS CloudFormation StackSets isn't able to create resources under the management account. If you wish to create the `DrataAutopilotRole` in the management account go to this [repo](https://github.com/drata/terraform-aws-drata-autopilot-role).

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack_set.stack_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set) | resource |
| [aws_cloudformation_stack_set_instance.instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack_set_instance) | resource |
| [aws_organizations_organization.organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_drata_external_id"></a> [drata\_external\_id](#input\_drata\_external\_id) | Drata External ID from the Drata UI. | `string` | n/a | yes |
| <a name="input_management_account_id"></a> [management\_account\_id](#input\_management\_account\_id) | Management account id from your organization. | `string` | n/a | yes |
| <a name="input_stackset_region"></a> [stackset\_region](#input\_stackset\_region) | Region where the stackset instance will be executed. | `string` | `"us-west-2"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->