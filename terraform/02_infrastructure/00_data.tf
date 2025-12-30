data "terraform_remote_state" "vpn" {
  backend = "local"
  config = {
    path = "../01_vpn/terraform.tfstate"
  }
}