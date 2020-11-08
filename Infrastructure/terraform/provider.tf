terraform {
  required_version = ">= 0.13"

  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }

  backend "remote" {
      organization = "Ahmed-Ibrahim"

      workspaces {
        name = "cloudrun-build"
      }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  credentials = var.service_account
}
