resource "null_resource" "remote-exec-master" {
    depends_on = ["baremetal_core_instance.Master"]
    provisioner "remote-exec" {
      connection {
        agent = false
        timeout = "10m"
        host = "${data.baremetal_core_vnic.MasterVnic.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
        "touch ~/Iam.Master.Halo",
      ]
    }
}

resource "null_resource" "remote-exec-minion" {
    depends_on = ["baremetal_core_instance.Minion"]
    provisioner "remote-exec" {
      connection {
        agent = false
        timeout = "10m"
        host = "${data.baremetal_core_vnic.MinionVnic.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
        "touch ~/Iam.Minion.YourSlave",
      ]
    }
}
