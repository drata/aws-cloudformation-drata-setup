# aws-cloudformation-drata-setup

AWS Cloudformation terraform script to create the Drata Autopilot role across an Organizational Unit.
***NOTE:*** Make sure you run this script with the management account credentials.

_Optionally you may create the CloudFormation StackSet directly in the console, download the [json template](https://github.com/drata/aws-cloudformation-drata-setup/blob/main/drata_cloudformation_stackset_template.json) and upload it as a template resource._

## Example Usage

The example below uses `ref=main` (which is appended in the URL),  but it is recommended to use a specific tag version (i.e. `ref=1.0.0`) to avoid breaking changes. Go to the [release page](https://github.com/drata/aws-cloudformation-drata-setup/releases) for a list of published versions.

Replace `YOUR_EXTERNAL_ID` with the external id provided in the Drata UI. i.e. `00000000-0000-0000-0000-000000000000`.

```
module "drata_role_cloudformation_stacksets" {
    source = "git::https://github.com/drata/aws-cloudformation-drata-setup.git?ref=main"
    role_sts_externalid = "YOUR_EXTERNAL_ID"
    # stackset_region = "REGION" # Uncomment if you'd like to change the default value of 'us-west-2'
    # organizational_unit_ids = ["ORG_ID_1", "ORG_ID_2"] # Uncomment if you'd like to change the default behavior, which assigns the role to all sub accounts within the organization
    # drata_aws_account_id = "XXXXXXXXXXXX" # Uncomment if you'd like to change the default value. The default value should be sufficient for most use cases
}
```



## Setup

The following steps will guide you on how to run this script.

1. Add the code above to your terraform code.
2. Replace `main` in `ref=main` with the latest version from the [release page](https://github.com/drata/aws-cloudformation-drata-setup/releases).
3. In your browser, open [https://app.drata.com/account-settings/connections/connection?provId=AWS_ORG_UNITS](https://app.drata.com/account-settings/connections/connection?provId=AWS_ORG_UNITS&provTypeSelected=Infrastructure&activeTab=browse&q=aws%20org&page=1).
4. Copy the `Drata External ID` from the AWS Org Units connection panel in Drata and replace `YOUR_EXTERNAL_ID` in the module with the ID you copied.
5. Replace `stackset_region` if the desired region is different than the default value `us-west-2`.
6. If you don't wish to assign the role to all sub accounts, add the organizational unit ids to `organizational_unit_ids`.
7. `drata_aws_account_id` shouldn't be set because the default value is enough for most use cases.
8. Back in your terminal, run terraform init to download/update the module.
9. Run terraform apply and **IMPORTANT** review the plan output before typing yes.
10. If successful, go back to the AWS console and verify the Role has been generated in all the sub accounts.
11. If you want to roll back the operations this script just performed, type `terraform destroy` and `enter`.

## Disclaimer

AWS CloudFormation StackSets isn't able to create resources under the management account. If you wish to create the `DrataAutopilotRole` in the management account you can use this [repo](https://github.com/drata/terraform-aws-drata-autopilot-role) or create it manually following our [help documentation](https://help.drata.com/en/articles/5048935-aws-connection-details#h_caf5c48b5d).

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
| <a name="input_drata_aws_account_id"></a> [drata\_aws\_account\_id](#input\_drata\_aws\_account\_id) | Drata's AWS account ID | `string` | `"269135526815"` | no |
| <a name="input_organizational_unit_ids"></a> [organizational\_unit\_ids](#input\_organizational\_unit\_ids) | Organizational Unit Ids to assign the role to. | `list(string)` | `null` | no |
| <a name="input_role_sts_externalid"></a> [role\_sts\_externalid](#input\_role\_sts\_externalid) | Drata External ID from the Drata UI. | `string` | n/a | yes |
| <a name="input_stackset_region"></a> [stackset\_region](#input\_stackset\_region) | Region where the stackset instance will be executed. | `string` | `"us-west-2"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->