terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_ssh_key" "mySSHKey" {
  name       = "aula-terraform-ssh-key"
  public_key = file("C:/.ssh/aula-terraform.pub")
}

resource "digitalocean_droplet" "myDroplet" {
  image    = "ubuntu-22-04-x64"
  name     = "aula-terraform-droplet"
  region   = "nyc3"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.mySSHKey.fingerprint]
}