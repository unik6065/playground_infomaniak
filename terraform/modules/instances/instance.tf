data "openstack_networking_subnet_ids_v2" "ext_subnets" {
  network_id = var.instance_network_external_id
}

resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool       = var.instance_network_external_name
  subnet_ids = data.openstack_networking_subnet_ids_v2.ext_subnets.ids
}

resource "openstack_networking_port_v2" "port_instance" {
  network_id = var.instance_network_internal_id
  security_group_ids = var.instance_security_groups_ids
  fixed_ip {
    subnet_id = var.instance_subnet_id
  }
}

resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  image_id        = var.instance_image_id
  flavor_name     = var.instance_flavor_name
  metadata        = var.metadatas
  key_pair        = var.instance_key_pair
  network {
    port = openstack_networking_port_v2.port_instance.id
  }
}

resource "openstack_networking_floatingip_associate_v2" "fip_associate" {
  floating_ip = openstack_networking_floatingip_v2.floatip_1.address
  port_id     = openstack_networking_port_v2.port_instance.id
}

