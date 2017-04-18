# Gets a list of Availability Domains
data "baremetal_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

# Gets the OCID of the OS image to use
data "baremetal_core_images" "OLImageOCID" {
    compartment_id = "${var.compartment_ocid}"
    operating_system = "${var.InstanceOS}"
    operating_system_version = "${var.InstanceOSVersion}"
}

# Gets a list of vNIC attachments on the instance
data "baremetal_core_vnic_attachments" "MasterVnics" { 
compartment_id = "${var.compartment_ocid}" 
availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}" 
instance_id = "${baremetal_core_instance.Master.id}" 
} 

# Gets the OCID of the first (default) vNIC
data "baremetal_core_vnic" "MasterVnic" { 
vnic_id = "${lookup(data.baremetal_core_vnic_attachments.MasterVnics.vnic_attachments[0],"vnic_id")}" 
}


data "baremetal_core_vnic_attachments" "MinionVnics" { 
compartment_id = "${var.compartment_ocid}" 
availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[var.AD - 0],"name")}" 
instance_id = "${baremetal_core_instance.Minion.id}" 
} 

# Gets the OCID of the first (default) vNIC
data "baremetal_core_vnic" "MinionVnic" { 
vnic_id = "${lookup(data.baremetal_core_vnic_attachments.MinionVnics.vnic_attachments[0],"vnic_id")}" 
}
