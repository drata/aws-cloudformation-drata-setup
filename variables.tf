variable "stackset_region" {
  type        = string
  default     = "us-west-2"
  description = "Region where the stackset instance will be executed."
}

variable "management_account_id" {
  type        = string
  description = "Management account id from your organization."
}

variable "drata_external_id" {
  type        = string
  description = "Retrieved ID from the Drata UI."
}

variable "role_name" {
  type        = string
  description = "Drata role name."
  default     = "DrataAutopilotRole"
}

variable "release_tag" {
  type        = string
  description = "Release tag utilized to target the terraform module that creates the role in the management account."
  default     = "main"
}
