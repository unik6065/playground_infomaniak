resource "openstack_networking_secgroup_v2" "ssh" {
  name        = "ssh-from-all"
  description = "ssh security group"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.ssh.id
}

resource "openstack_networking_secgroup_v2" "openvpn" {
  name        = "openvpn"
  description = "openvpn security group"
}

resource "openstack_networking_secgroup_rule_v2" "openvpn_upd" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 1194
  port_range_max    = 1194
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.openvpn.id
}

resource "openstack_networking_secgroup_rule_v2" "openvpn_tcp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1194
  port_range_max    = 1194
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.openvpn.id
}

resource "openstack_networking_secgroup_v2" "ssh-internal" {
  name        = "ssh-from-internal"
  description = "ssh internal security group"
}

resource "openstack_networking_secgroup_rule_v2" "ssh-internal" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.network_subnet_cidr
  security_group_id = openstack_networking_secgroup_v2.ssh-internal.id
}

resource "openstack_networking_secgroup_v2" "all_internal" {
  name        = "all_internal"
  description = "all_internal security group"
}

resource "openstack_networking_secgroup_rule_v2" "all_internal_tcp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = var.network_subnet_cidr
  security_group_id = openstack_networking_secgroup_v2.all_internal.id
  lifecycle {
    ignore_changes = [ port_range_min,  port_range_max]
  }
}

resource "openstack_networking_secgroup_rule_v2" "all_internal_udp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = var.network_subnet_cidr
  security_group_id = openstack_networking_secgroup_v2.all_internal.id
  lifecycle {
    ignore_changes = [ port_range_min,  port_range_max]
  }
}

resource "openstack_networking_secgroup_v2" "proxy" {
  name        = "proxy"
  description = "proxy security group"
}

resource "openstack_networking_secgroup_rule_v2" "proxy_http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.proxy.id
}

resource "openstack_networking_secgroup_rule_v2" "proxy_https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.proxy.id
}

resource "openstack_networking_secgroup_v2" "consul" {
  name        = "consul"
  description = "consul"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_consul_dns_tcp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8600
  port_range_max    = 8600
  remote_ip_prefix  = var.network_subnet_cidr
  security_group_id = openstack_networking_secgroup_v2.consul.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_consul_dns_udp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 8600
  port_range_max    = 8600
  remote_ip_prefix  = var.network_subnet_cidr
  security_group_id = openstack_networking_secgroup_v2.consul.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_consul_http_grpc" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8500
  port_range_max    = 8503
  remote_ip_prefix  = var.network_subnet_cidr
  security_group_id = openstack_networking_secgroup_v2.consul.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_consul_wlan_tcp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8300
  port_range_max    = 8302
  remote_ip_prefix  = var.network_subnet_cidr
  security_group_id = openstack_networking_secgroup_v2.consul.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_consul_wlan_udp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 8300
  port_range_max    = 8302
  remote_ip_prefix  = var.network_subnet_cidr
  security_group_id = openstack_networking_secgroup_v2.consul.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_consul_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  port_range_min    = 0
  port_range_max    = 0
  remote_ip_prefix  = var.network_subnet_cidr
  security_group_id = openstack_networking_secgroup_v2.consul.id
}

resource "openstack_networking_secgroup_v2" "node_exporter" {
  name        = "node_exporter"
  description = "node_exporter"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_node_exporter" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9100
  port_range_max    = 9100
  remote_ip_prefix  = var.network_subnet_cidr
  security_group_id = openstack_networking_secgroup_v2.node_exporter.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_vmagent" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8428
  port_range_max    = 8429
  remote_ip_prefix  = var.network_subnet_cidr
  security_group_id = openstack_networking_secgroup_v2.node_exporter.id
}

