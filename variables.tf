variable "stackset_region" {
  type        = string
  default     = "us-west-2"
  description = "Region where the stackset instance will be executed."
}

variable "drata_aws_account_id" {
  type        = string
  default     = "269135526815"
  description = "Drata's AWS account ID"
}

variable "role_sts_externalid" {
  type        = string
  description = "Drata External ID from the Drata UI."
}

variable "organizational_unit_ids" {
  type        = list(string)
  default     = null
  description = "Organizational Unit Ids to assign the role to."
}

variable "target_account_ids" {
  type        = list(string)
  default     = null
  description = "List of specific account IDs to target. When provided, only these accounts will be targeted (in combination with organizational_unit_ids if specified). If null, all accounts in the specified OUs will be targeted."
  validation {
    condition = var.target_account_ids == null ? true : alltrue([
      for account_id in var.target_account_ids : can(regex("^[0-9]{12}$", account_id))
    ])
    error_message = "Account IDs must be exactly 12 digits."
  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to apply to all created resources."
}

variable "stack_set_name" {
  type        = string
  default     = "drata-role-terraform-stack-set"
  description = "Name of the CloudFormation StackSet. Change this if you need to avoid naming conflicts."
}

variable "account_filter_type" {
  type        = string
  default     = "INTERSECTION"
  description = <<-EOT
  The type of account filter to apply when both organizational_unit_ids and target_account_ids are specified:
  - NONE: Deploy to all accounts in specified OUs
  - INTERSECTION: Deploy only to specified accounts if they exist within the OU hierarchy
  - DIFFERENCE: Deploy to all accounts in the OU hierarchy except the specified accounts
  - UNION: Deploy to all accounts in the OU hierarchy plus the specified accounts
  Note: When using root OU, you can target any account in your organization.
  EOT
  
  validation {
    condition     = contains(["NONE", "INTERSECTION", "DIFFERENCE", "UNION"], var.account_filter_type)
    error_message = "account_filter_type must be one of: NONE, INTERSECTION, DIFFERENCE, UNION"
  }


}