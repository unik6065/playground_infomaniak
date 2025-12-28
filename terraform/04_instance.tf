module "openvpn" {
  source                         = "./modules/instances"
  instance_count                 = 5
  instance_name                  = "openvpn"
  instance_key_pair              = openstack_compute_keypair_v2.ssh_public_key.name
  instance_security_groups_ids   = [openstack_networking_secgroup_v2.openvpn.id, openstack_networking_secgroup_v2.ssh.id]
  instance_network_internal_name = var.network_internal_dev
  instance_network_internal_id   = module.network_dev.network_id
  instance_network_external_name = var.network_external_name
  instance_network_external_id   = var.network_external_id
  metadatas = {
    environment = "dev"
  }
  instance_subnet_id = module.network_dev.subnet_id
  depends_on         = [module.network_dev, openstack_networking_secgroup_rule_v2.openvpn_tcp]

}