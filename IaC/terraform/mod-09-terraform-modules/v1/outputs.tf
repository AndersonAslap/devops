output "wp_lb_ip" {
  value       = digitalocean_loadbalancer.wp_lb.ip
  description = "Endereço IP do Load Balancer"
}

output "wp_vm_ips" {
  value       = digitalocean_droplet.vm_wp[*].ipv4_address
  description = "Endereços IP das VMs do WordPress"
}

output "nfs_vm_ips" {
  value       = digitalocean_droplet.vm_nfs.ipv4_address
  description = "Endereço IP da VM do NFS"
}

output "wp_db_user" {
  value       = digitalocean_database_user.wp_databse_user.name
  description = "Nome de usuário do banco de dados"
}

output "wp_db_pwd" {
  value       = digitalocean_database_user.wp_databse_user.password
  description = "Senha do usuário do banco de dados"
  sensitive   = true
}