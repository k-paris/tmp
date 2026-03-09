# Output all VM IDs
output "vm_ids" {
  description = "Map of VM names to their UUIDs"
  value       = { for k, v in module.nutanix_vm : k => v.vm_id }
}

# Output all VM IP addresses
output "vm_ip_addresses" {
  description = "Map of VM names to their IP addresses"
  value       = { for k, v in module.nutanix_vm : k => v.vm_ip_address }
}

# Combined output with all VM details
output "vm_details" {
  description = "Map of VM names to their details (ID and IP)"
  value = {
    for k, v in module.nutanix_vm : k => {
      id         = v.vm_id
      ip_address = v.vm_ip_address
    }
  }
}