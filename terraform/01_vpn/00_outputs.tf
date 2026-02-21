output "security_group_ssh_internal_id" {
  value = openstack_networking_secgroup_v2.ssh-internal.id
}

output "security_group_consul_id" {
  value = openstack_networking_secgroup_v2.consul.id
}

output "security_group_node_exporter_id" {
  value = openstack_networking_secgroup_v2.node_exporter.id
}


output "network_dev_subnet_id" {
  value = module.network_dev.subnet_id
}

output "network_dev_id" {
  value = module.network_dev.network_id
}