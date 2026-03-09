variable "nutanix_username" {
  description = "Nutanix API username"
  type        = string
  default = ""
  sensitive = true
}

variable "nutanix_password" {
  description = "Nutanix API password"
  type        = string
  default = ""   
  sensitive   = true
}
variable "nutanix_endpoint" {
  description = "Nutanix API endpoint URL"
  type        = string
  default = "172.16.3.132"
  sensitive   = true
}

variable "cluster_name" {
  description = "Nutanix Cluster Name"
  type        = string
  default = "TestCluster"
  sensitive   = true
}