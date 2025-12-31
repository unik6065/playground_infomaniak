

resource "null_resource" "ansible_infrastructure" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<-EOT
      sleep 20s;
      ANSIBLE_CONFIG=../../ansible/ansible.cfg ansible-playbook -u ${var.default_user} -i ../../ansible/openstack.yml --private-key ~/.ssh/info ../../ansible/infrastructure_base.yml;
      ANSIBLE_CONFIG=../../ansible/ansible.cfg ansible-playbook -u ${var.default_user} -i ../../ansible/openstack.yml -e users_default_account=${var.default_user} --private-key ~/.ssh/info ../../ansible/infrastructure_consul.yml;
    EOT
  }
  depends_on = [module.consul]
}