module "consul" {
  source                         = "../modules/instances"
  instance_count                 = 3
  instance_name                  = "consul"
  instance_key_pair              = "default_key"
  instance_security_groups_ids   = [data.terraform_remote_state.vpn.outputs.security_group_consul_id, data.terraform_remote_state.vpn.outputs.security_group_ssh_internal_id]
  instance_network_internal_name = var.network_internal_dev
  instance_network_internal_id   = data.terraform_remote_state.vpn.outputs.network_dev_id
  instance_ssh_key               = var.ssh_public_key_default_user
  instance_volumes_count         = 1
  metadatas = {
    environment = "dev",
    app         = "consul"
  }
  instance_subnet_id = data.terraform_remote_state.vpn.outputs.network_dev_subnet_id

}