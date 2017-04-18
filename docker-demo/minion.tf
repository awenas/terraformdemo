resource "baremetal_core_instance" "Minion" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[var.AD - 0],"name")}" 
  compartment_id = "${var.compartment_ocid}"
  display_name = "Minion"
#  hostname_label = "kvm1"
  image = "${lookup(data.baremetal_core_images.OLImageOCID.images[0], "id")}"
  shape = "${var.InstanceShape}"
  subnet_id = "${baremetal_core_subnet.MinionSubnet.id}"
  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data = "${base64encode(file(var.BootStrapFile))}"}
}
