# data "nutanix_subnet" "subnet" {
#   subnet_name = "net05"
# }

resource "nutanix_virtual_machine" "vm" {
	name					= var.name
	cluster_uuid			= var.cluster_uuid
	
    description 			= var.description
    power_state 			= var.power_state

	# Hardware specifications (CPU, Memory)
	#    Memory size in MiB: 
	#        - default is 2048 MiB
	#    CPU configuration: 
	#		 - number of sockets            (default is 1)
	#        - number of vCPUs per socket   (default is 2)
	memory_size_mib 		= var.memory_size_mib
    num_vcpus_per_socket 	= var.num_vcpus_per_socket
    num_sockets 			= var.num_sockets

    # Guest Customization using Cloud-Init
	guest_customization_cloud_init_user_data = base64encode(
    templatefile("${path.module}/linux_cloud_init.tpl", {
      hostname        = var.vm_hostname
      username        = var.vm_username
      plain_password  = var.vm_plaintext_password
    })
    )


	# ------------------------------   Disk Configuration   -------------------------------------

	dynamic "disk_list" {
        for_each = var.disk_list
        content {
            # For OS disk - use data_source_reference
            data_source_reference = disk_list.value.image_uuid != null && disk_list.value.image_uuid != "" ? {
                kind = "image"
                uuid = disk_list.value.image_uuid
            } : null

            # For additional disks - set size and device properties
            disk_size_mib = disk_list.value.disk_size_gb != null ? disk_list.value.disk_size_gb * 1024 : null

            dynamic "device_properties" {
                for_each = disk_list.value.device_type != null ? [1] : []
                content {
                    device_type = disk_list.value.device_type
                    disk_address = {
                        adapter_type = disk_list.value.adapter_type
                        device_index = disk_list.value.device_index
                    }
                }
            }
        }
    }

	# -------------------------------------------------------------------------------------------

	# # OS disk
	# disk_list {
	# 	data_source_reference {
	# 		kind = "image"
	# 		uuid = var.os_image_uuid
	# 	}
	# }

	# # -------------------------------------------------------------------------------------------

	# # Additional disk
	# disk_list {
	# 	# Calculate disk size
	# 	disk_size_mib = var.additional_disk_size_gb * 1024 * 1024 * 1024
	# 	device_properties {
	# 		device_type = var.device_type          # default is "DISK"
	# 		disk_address {
	# 			adapter_type  = var.adapter_type   # default is "SCSI"
	# 			device_index = var.device_index    # default is 1
	# 		}
	# 	}
	# }

	# -------------------------------------------------------------------------------------------

	nic_list {
    subnet_uuid = var.subnet_uuid

    # Use static IP if provided
    dynamic "ip_endpoint_list" {
      for_each = var.ip_address != "" ? [1] : []
      content {
        ip   = var.ip_address
        type = "ASSIGNED"
      }
    }
  }
	
}