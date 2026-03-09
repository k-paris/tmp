output "vm_id" {
  value = nutanix_virtual_machine.vm.metadata.uuid
    description = "The ID of the created virtual machine."
}

output "vm_ip_address" {
  value       = nutanix_virtual_machine.vm.nic_list[0].ip_endpoint_list[0].ip
  description = "The IP address of the created virtual machine."
}