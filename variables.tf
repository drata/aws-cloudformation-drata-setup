variable "stackset_region" {
  type        = string
  default     = "us-west-2"
  description = "Region where the stackset instance will be executed."
}

variable "role_sts_externalid" {
  type        = string
  default     = null
  description = "Drata External ID from the Drata UI."
}
