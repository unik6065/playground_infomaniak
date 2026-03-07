

resource "null_resource" "ansible_infrastructure" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<-EOT
      sleep 20s;
      ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS} -e users_default_account=${var.default_user} ../../ansible/infrastructure_base.yml;
      ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS}  ../../ansible/infrastructure_consul.yml;
      ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS}  ../../ansible/infrastructure_consul_openvpn.yml;
      ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS}  ../../ansible/infrastructure_consul_services.yml;
      ${var.ANSIBLE_ENV_VARS} ${var.ANSIBLE_COMMAND} ${var.default_user} ${var.ANSIBLE_OPTIONS}  ../../ansible/infrastructure_monitoring.yml;
    EOT
  }
  depends_on = [module.consul, module.monitoring]
}