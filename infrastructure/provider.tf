provider "google" {
  project     = "paul-devops"
  region      = "us-central1"
}

terraform {
    backend "gcs" {
        bucket = "paularinze-gke-tf-state-staging"
        prefix = "terraform/state"
    }
}