provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.13.0"
    }
  }
  required_version = ">= 1.1.5"
}
