module iam {
  source = "./modules/iam"
  project_id = var.project_id

  # providers = {
  #   google = google.impersonated
  # }
}

# data "google_service_account_access_token" "default" {
#   target_service_account = "my-service-account@${var.project_id}.iam.gserviceaccount.com"
#   scopes                 = ["userinfo-email", "cloud-platform"]
#   lifetime               = "3600s"
# }

module compute {
  source = "./modules/compute"
  # project_id = var.project_id
}
