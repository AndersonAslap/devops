terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

module "wp_do" {
  source  = "app.terraform.io/aslap-digital/wp-do/digitalocean"
  version = "1.0.1"

  # variáveis do módulo
  region      = var.region
  wp_vm_count = var.wp_vm_count
  vms_ssh     = digitalocean_ssh_key.ssh.fingerprint
}

resource "digitalocean_ssh_key" "ssh" {
  name       = "wp-ssh"
  public_key = file("C:/.ssh/aula-terraform.pub")
}