output "acl_template" {
  description = "ACL template object."
  value       = var.create_acl ? equinix_network_acl_template.this[0] : null
}

output "ssh_user" {
  description = "SSH user object."
  value       = var.create_acl ? equinix_network_ssh_user.this[0] : null
}

output "network_device" {
  description = "Equinix network device object."
  value       = equinix_network_device.this
}