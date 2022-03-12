provider "google" {
  project = "aleksandrov-gatech-test"
  region  = var.region
}

terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 1.1.5"
}
