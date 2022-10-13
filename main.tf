data "equinix_network_account" "this" {
  metro_code = var.metro_code
}

data "http" "myip" {
  count = var.create_acl ? 1 : 0

  url = "http://ifconfig.me"
}

resource "equinix_network_acl_template" "this" {
  count = var.create_acl ? 1 : 0

  name        = var.acl_name
  description = var.acl_description

  inbound_rule {
    subnet      = "${chomp(data.http.myip[0].response_body)}/32"
    protocol    = "IP"
    src_port    = "any"
    dst_port    = "any"
    description = "Inbound from my IP"
  }
}

resource "equinix_network_device" "this" {
  metro_code      = data.equinix_network_account.this.metro_code
  account_number  = data.equinix_network_account.this.number
  type_code       = var.type_code
  byol            = false
  self_managed    = false
  core_count      = var.core_count
  package_code    = var.package_code
  version         = var.device_version
  throughput      = var.throughput
  throughput_unit = var.throughput_unit
  name            = var.device_name
  hostname        = var.device_hostname
  notifications   = var.notifications
  term_length     = var.term_length

  acl_template_id = local.acl_template_id
}

resource "equinix_network_ssh_user" "this" {
  count = var.create_ssh_user ? 1 : 0

  username   = var.ssh_username
  password   = var.ssh_password
  device_ids = [equinix_network_device.this.uuid]
}

locals {
  acl_template_id = var.create_acl ? equinix_network_acl_template.this[0].id : var.acl_template_id
}