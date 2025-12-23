output "network_id" {
  description = "ID of the network"
  value       = openstack_networking_network_v2.network_name.id
}

output "subnet_id"{
  description = "ID od the subnet"
  value = openstack_networking_subnet_v2.network_subnet.id
}