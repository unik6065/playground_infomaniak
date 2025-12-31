variable "instance_network_external_id" {
  type    = string
  default = ""
}

variable "instance_network_external_name" {
  type    = string
  default = ""
}

variable "instance_name" {
  type = string
}

variable "instance_default_user" {
  type = string
  default = ""
}

variable "instance_image_id" {
  type = string
  default = "359e3ea8-a295-496f-9b41-06db46b23e14"
}

variable "instance_flavor_name" {
  type    = string
  default = "a1-ram2-disk20-perf1"
}

variable "instance_security_groups_ids" {
  type    = list(any)
}

variable "instance_key_pair" {
  type = string
}

variable "metadatas" {
  type = map(string)
  default = {
    "environment" = "dev"
  }
}

variable "instance_ssh_key" {
  type = string
}

variable "instance_network_internal_name" {
  type    = string
}

variable "instance_network_internal_id" {
    type = string  
}

variable "instance_subnet_id" {
  type    = string
}

variable "instance_count" {
  type = number
  default = 1
}

variable "public_floating_ip" {
  type = bool
  default = false
}

variable "public_floating_ip_fixed" {
  type = string
  default = ""
}

variable "instance_internal_fixed_ip" {
    type = string
    default = ""
}

variable "instance_volumes_count" {
  type = number
  default = 0
}

variable "instance_volumes_size" {
  type = number
  default = 20
}

variable "instance_volumes_type" {
  type = string
  default = "CEPH_1_perf1"
}