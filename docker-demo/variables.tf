variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}

variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}

#variable "SubnetOCID" {}

# Choose an Availability Domain
variable "AD" {
    default = "1"
}

variable "timeout_minutes" {
    default = 5
}

variable "InstanceShape" {
    default = "VM.Standard1.2"
}

variable "InstanceOS" {
    default = "CentOS"
}

variable "InstanceOSVersion" {
    default = "7"
}

variable "2TB" {
    default = "2097152"
}

variable "256GB" {
    default = "262144"
}

variable "MasterBootStrapFile" {
    default = "./userdata/masterbootstrap"
}

variable "MinionBootStrapFile" {
    default = "./userdata/minionbootstrap"
}
