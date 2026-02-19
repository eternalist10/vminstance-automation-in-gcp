terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

data "google_client_openid_userinfo" "current_user" {
}

resource "google_project_iam_member" "admin-account-iam" {
  for_each = toset([
    "roles/iam.serviceAccountCreator", # Primary role to create SAs
    "roles/iam.serviceAccountAdmin",   # Broad SA management
    "roles/iam.serviceAccountUser",     # To attach SAs to resources
    "roles/iam.serviceAccountTokenCreator"  #to impersonate as another service account"
  ])
  
  project = var.project_id
  role = each.value
  member = "serviceAccount:${data.google_client_openid_userinfo.current_user.email}"
}

resource "google_service_account" "sa_2" {
  depends_on = [ google_project_iam_member.admin-account-iam]
  account_id   = "my-service-account"
}

resource "google_service_account_iam_member" "sa_2_roles" {
   for_each = toset([
    "roles/iam.serviceAccountCreator",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser", 
    "roles/iam.serviceAccountTokenCreator"
  ])

  service_account_id = google_service_account.sa_2.account_id
  role = each.value
  member = google_service_account.sa_2.email
}