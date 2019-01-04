# Provider Configuration
provider "google" {
  project = "${var.compute_project}"
}

# Terraform Configuration
terraform {
  required_version = "0.11.7"

  backend "gcs" {
    bucket = "terraform-platform-devops-npe"
    prefix = "terraform/state/carbon/region-us-east4/base-image-templates"
  }
}

# Fetching bifrost internal ip
data "terraform_remote_state" "bifrost-address" {
  backend = "gcs"

  config {
    bucket = "terraform-platform-devops-npe"
    prefix = "terraform/state/carbon/region-us-east4/address/bifrost-address/"
  }
}

# Locals for NPE
locals {
  ssh_key = "${file(var.ssh_key)}"  
  bifrost_ip = "${data.terraform_remote_state.bifrost-address.bifrost_internal_ip}"
}