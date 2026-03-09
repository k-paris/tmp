module "nutanix_vm" {
  source   = "../Modules/VM"
  for_each = local.vms

  # Use each.key as the name (the key in the vms map)
  name                    = each.key
  cluster_uuid            = each.value.cluster_uuid
  subnet_uuid             = lookup(each.value, "subnet_uuid", "")
  num_sockets             = lookup(each.value, "num_sockets", 1)
  num_vcpus_per_socket    = lookup(each.value, "num_vcpus_per_socket", 1)
  memory_size_mib         = lookup(each.value, "memory_size_mib", 1024)
  power_state             = lookup(each.value, "power_state", "ON")
  disk_list               = lookup(each.value, "disk_list", [])
  description             = lookup(each.value, "description", "")
  
  # Static IP address from IP pool
  ip_address              = lookup(each.value, "ip_address", "")
  
  # Cloud-init settings
  vm_hostname             = lookup(each.value, "vm_hostname", each.key)
  vm_username             = lookup(each.value, "vm_username", "")
  vm_plaintext_password   = lookup(each.value, "vm_plaintext_password", "")
}