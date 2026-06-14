output "stack_wp_lb_ip" {
  value       = module.wp_do.wp_lb_ip
  description = "Endereço IP do Load Balancer"
}

output "stack_wp_vm_ips" {
  value       = module.wp_do.wp_vm_ips
  description = "Endereços IP das VMs do WordPress"
}

output "stack_nfs_vm_ips" {
  value       = module.wp_do.nfs_vm_ips
  description = "Endereço IP da VM do NFS"
}

output "stack_wp_db_user" {
  value       = module.wp_do.wp_db_user
  description = "Nome de usuário do banco de dados"
}

output "stack_wp_db_pwd" {
  value       = module.wp_do.wp_db_pwd
  description = "Senha do usuário do banco de dados"
  sensitive   = true
}