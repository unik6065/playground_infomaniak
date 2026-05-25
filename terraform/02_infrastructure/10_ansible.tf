

resource "null_resource" "ansible_infrastructure" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<-EOT
      sleep 20s;
      # # Base
      # ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS} -e users_default_account=${var.default_user} ../../ansible/infrastructure_base.yml;
      # # Consul Master
      # ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS}  ../../ansible/infrastructure_consul.yml;
      # # Consul openvpn
      # ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS}  ../../ansible/infrastructure_consul_openvpn.yml;
      # # consul services
      # ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS}  ../../ansible/infrastructure_consul_services.yml;
      # # Monitoring
      # ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS}  ../../ansible/infrastructure_monitoring.yml;
      # # Loki
      # ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS}  ../../ansible/infrastructure_loki.yml;
      # # Proxy
      # ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS}  ../../ansible/infrastructure_proxy.yml;
      # # Postgresql
      ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS}  ../../ansible/infrastructure_postgresql_ha.yml;
    EOT
  }
  depends_on = [module.consul, module.monitoring, module.traefik, module.loki, module.postgresql]
}