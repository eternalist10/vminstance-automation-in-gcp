terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "google" {
  alias                       = "impersonated"
  impersonate_service_account = "my-service-account@${var.project_id}.iam.gserviceaccount.com"
  access_token = data.google_service_account_access_token.default.access_token
}