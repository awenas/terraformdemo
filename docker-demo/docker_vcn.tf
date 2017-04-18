
variable "VPC-CIDR" {
  default = "10.1.0.0/16"
}



resource "baremetal_core_virtual_network" "CompleteVCN" {
  cidr_block = "${var.VPC-CIDR}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "DockerVCN"
}

resource "baremetal_core_internet_gateway" "CompleteIG" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "DockerIG"
    vcn_id = "${baremetal_core_virtual_network.CompleteVCN.id}"
}

resource "baremetal_core_route_table" "RouteForComplete" {
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${baremetal_core_virtual_network.CompleteVCN.id}"
    display_name = "RouteTableForDocker"
    route_rules {
        cidr_block = "0.0.0.0/0"
        network_entity_id = "${baremetal_core_internet_gateway.CompleteIG.id}"
    }
}

resource "baremetal_core_security_list" "Dockerseclist" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "Dockerseclist"
    vcn_id = "${baremetal_core_virtual_network.CompleteVCN.id}"
    egress_security_rules = [{
        destination = "0.0.0.0/0"
        protocol = "6"
    },
	{
        destination = "10.1.0.0/16"
        protocol = "all"
    }
	]
    ingress_security_rules = [{
        tcp_options {
            "max" = 22
            "min" = 22
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
	{
	protocol = "all"
	source = "${var.VPC-CIDR}"
    }]
}


resource "baremetal_core_subnet" "MasterSubnet" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  cidr_block = "10.1.1.0/24"
  display_name = "MasterSubnet"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${baremetal_core_virtual_network.CompleteVCN.id}"
  route_table_id = "${baremetal_core_route_table.RouteForComplete.id}"
  security_list_ids = ["${baremetal_core_security_list.Dockerseclist.id}"]
}


resource "baremetal_core_subnet" "MinionSubnet" {
  availability_domain = "${lookup(data.baremetal_identity_availability_domains.ADs.availability_domains[var.AD - 0],"name")}"
  cidr_block = "10.1.2.0/24"
  display_name = "MinionSubnet"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${baremetal_core_virtual_network.CompleteVCN.id}"
  route_table_id = "${baremetal_core_route_table.RouteForComplete.id}"
  security_list_ids = ["${baremetal_core_security_list.Dockerseclist.id}"]
}







