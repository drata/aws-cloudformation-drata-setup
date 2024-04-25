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
