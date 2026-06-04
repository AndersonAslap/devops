variable "digitalocean_token" {
  type        = string
  description = "Token de acesso à API do DigitalOcean"
}

variable "droplet_name" {
  default     = "vm-aula"
  type        = string
  description = "Nome do Droplet a ser criado"
}

variable "droplet_region" {
  default     = "nyc1"
  type        = string
  description = "Região onde o Droplet será criado"
}

variable "droplet_size" {
  default     = "s-1vcpu-1gb"
  type        = string
  description = "Tamanho dos Droplets a ser criado"
}

variable "ssh_key_name" {
  default     = "aula-terraform"
  type        = string
  description = "Nome da chave SSH a ser utilizada"
}

variable "vms_count" {
  default     = 1
  type        = number
  description = "Número de VMs a serem criadas"
}