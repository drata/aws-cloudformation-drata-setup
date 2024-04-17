variable "stackset_region" {
  type        = string
  default     = "us-west-2"
  description = "Region where the stackset instance will be executed."
}

variable "drata_external_id" {
  type        = string
  description = "Drata External ID from the Drata UI."
}
