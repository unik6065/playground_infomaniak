data "openstack_networking_subnet_ids_v2" "ext_subnets" {
  network_id = var.network_external_id
}

resource "openstack_networking_floatingip_v2" "floating_1" {
  pool       = var.network_external_name
  subnet_ids = data.openstack_networking_subnet_ids_v2.ext_subnets.ids
}

resource "openstack_networking_port_v2" "port_openvpn" {
  network_id = openstack_networking_network_v2.network_internal.id

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.network_subnet.id
  }
}

resource "openstack_compute_instance_v2" "openvpn" {
  name        = "openvpn"
  image_id    = var.instance_image_id
  flavor_name = var.instance_flavor_name
  metadata    = var.metadatas
  security_groups = [openstack_networking_secgroup_v2.openvpn.name,
  openstack_networking_secgroup_v2.ssh.name, "default"]
  key_pair = openstack_compute_keypair_v2.ssh_public_key.name
  network {
    port = openstack_networking_port_v2.port_openvpn.id
  }
  depends_on = [openstack_networking_subnet_v2.network_subnet, openstack_networking_secgroup_v2.openvpn]
}

resource "openstack_networking_floatingip_associate_v2" "fip_associate" {
  floating_ip = openstack_networking_floatingip_v2.floating_1.address
  port_id     = openstack_compute_instance_v2.openvpn.network[0].port
}