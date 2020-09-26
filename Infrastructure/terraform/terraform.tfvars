variable "gcp_project_id" {
  type        = string
  description = "Project id"
  default     = "my-dev-290020"
}

variable "gcp_region" {
  type        = string
  description = "Region"
  default     = "us-central1"
}

variable "gcp_image_name" {
  type        = string
  description = "Image name"
  default     = "symfony"
}

variable "gcp_cloudrun_service_name" {
  type        = string
  description = "Service name"
  default     = "cloudrun-symfony"
}
