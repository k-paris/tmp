variable "name" {
    description = "The name of the virtual machine."
    type        = string     
}

variable "cluster_uuid" {
    description = "The UUID of the cluster where the virtual machine will be created."
    type        = string     
}

variable "memory_size_mib" {
    description = "The memory size of the virtual machine in MiB."
    type        = number
    default     = 2048
}

variable "num_vcpus_per_socket" {
    description = "The number of vCPUs per socket."
    type        = number
    default     = 2
}

variable "num_sockets" {
    description = "The number of CPU sockets."
    type        = number
    default     = 1
}

variable "description" {
    description = "The description of the virtual machine."
    type        = string
    default     = "Virtual Machine created using Terraform"
}

variable "power_state" {
    description = "The power state of the virtual machine."
    type        = string
    default     = "ON"
}


variable "disk_list" {
    description = "List of disks to attach to the VM. For OS disk, provide image_uuid. For additional disks, provide disk_size_gb and device properties."
    type = list(object({
        image_uuid    = optional(string)  # For OS disk - the image UUID
        disk_size_gb  = optional(number)  # For additional disks - size in GB
        device_type   = optional(string)  # e.g., "DISK"
        adapter_type  = optional(string)  # e.g., "SCSI"
        device_index  = optional(number)  # e.g., 1
    }))
    default = []
}

variable "ip_address" {
  description = "Static IP address to assign to the VM"
  type        = string
  default     = ""
}


# variable "os_image_uuid" {
#     description = "The UUID of the OS image to be used for the virtual machine."
#     type        = string     
# }

# variable "additional_disk_size_gb" {
#     description = "The size of the additional disk to be attached to the virtual machine in GB."
#     type        = number
#     default     = 20
# }

# variable "device_type" {
#     description = "The device type for the additional disk."
#     type        = string
#     default     = "DISK"
# }

# variable "adapter_type" {
#     description = "The adapter type for the additional disk."
#     type        = string
#     default     = "SCSI"
# }

# variable "device_index" {
#     description = "The device index for the additional disk."
#     type        = number
#     default     = 1
# }


variable "vm_hostname" { 
    type = string 
    default = "ubuntu-cloud-vm" 
}
variable "vm_username" { 
    type = string 
    default = "ubuntu" 
}
variable "vm_plaintext_password" { 
    type = string 
    default = "VMware1!" 
}

variable "subnet_uuid" {
    description = "The UUID of the subnet to which the virtual machine will be connected."
    type        = string    
}