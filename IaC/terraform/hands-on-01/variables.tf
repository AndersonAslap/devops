variable "digitalocean_token" {
}

variable "droplet_name" {
  default = "vm-aula"
}

variable "droplet_region" {
  default = "nyc1"
}

variable "droplet_size" {
  default = "s-1vcpu-1gb"
}

variable "ssh_key_name" {
  default = "aula-terraform"
}