terraform {
  required_providers {
    nutanix = {
      source = "nutanix/nutanix"
      version = "2.3.1"
    }
  }
}

provider "nutanix" {
  username = var.nutanix_username
  password = var.nutanix_password
  endpoint = var.nutanix_endpoint
  insecure = true
}

data "nutanix_cluster" "cluster" {
  name = var.cluster_name
}