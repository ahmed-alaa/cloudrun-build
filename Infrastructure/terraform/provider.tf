terraform {
  required_version = ">= 0.12"
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  credentials = file("account.json")
}
