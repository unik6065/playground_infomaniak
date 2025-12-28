data "openstack_networking_subnet_ids_v2" "ext_subnets" {
  count = var.public_floating_ip ? 1: 0
  network_id = var.instance_network_external_id
}

resource "openstack_networking_floatingip_v2" "floatip_1" {
  count = var.public_floating_ip && var.public_floating_ip_fixed == "" ? 1: 0
  pool       = var.instance_network_external_name
  subnet_ids = data.openstack_networking_subnet_ids_v2.ext_subnets[count.index].ids
}

resource "openstack_networking_port_v2" "port_instance" {
  count = var.instance_count
  network_id = var.instance_network_internal_id
  security_group_ids = var.instance_security_groups_ids
  fixed_ip {
    subnet_id = var.instance_subnet_id
    ip_address = var.instance_internal_fixed_ip == "" ? "": "${var.instance_internal_fixed_ip}${count.index+1}"
  }
}

resource "openstack_compute_instance_v2" "instance" {
  count           = var.instance_count
  name            = "${var.instance_name}${count.index + 1}"
  image_id        = var.instance_image_id
  flavor_name     = var.instance_flavor_name
  metadata        = var.metadatas
  key_pair        = var.instance_key_pair
  network {
    port = openstack_networking_port_v2.port_instance[count.index].id
   }
}

resource "openstack_networking_floatingip_associate_v2" "fip_associate" {
  count = var.public_floating_ip ? 1: 0
  floating_ip = var.public_floating_ip_fixed != "" ? var.public_floating_ip_fixed : openstack_networking_floatingip_v2.floatip_1[count.index].address
  port_id     = openstack_networking_port_v2.port_instance[count.index].id
}

