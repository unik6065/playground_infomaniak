
output "instance_internal_ip" {
  description = "Internal"
  value       = try(openstack_compute_instance_v2.instance[*].network[0].fixed_ip_v4,null)
}

output "instance_external_ip" {
  description = "Public"
  value       = try(openstack_networking_floatingip_v2.floatip_1[0].address,null)
}
