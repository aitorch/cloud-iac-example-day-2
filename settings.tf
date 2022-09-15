terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.36.0"
    }
  }
  backend "gcs" {
    bucket = "cloud102-tf-states"
    prefix = "states"
  }
}

provider "google" {
  project = "cloud-comp-102"
}

