# Output the private and public IPs of the instance

output "InstancePrivateIP" {
value = ["${data.baremetal_core_vnic.MasterVnic.private_ip_address}"]
value = ["${data.baremetal_core_vnic.MinionVnic.private_ip_address}"]
}

output "InstancePublicIP" {
value = ["${data.baremetal_core_vnic.MasterVnic.public_ip_address}"]
value = ["${data.baremetal_core_vnic.MinionVnic.public_ip_address}"]
}

