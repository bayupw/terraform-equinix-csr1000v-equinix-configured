# Terraform Equinix Fabric Equinix-configured Cisco CSR 1000v router

Terraform module for deploying an Equinix-configured Cisco CSR 1000V router in Equinix Fabric.

To run this project, you will need to set the following environment variables or the [shared configuration and credentials files](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).
- EQUINIX_API_CLIENTID
- EQUINIX_API_CLIENTSECRET

See the [Developer Platform](https://developer.equinix.com/docs?page=/dev-docs/fabric/overview) page on how to generate Client ID and Client Secret.

## Sample usage

```hcl
module "csr1000v" {
  source          = "bayupw/csr1000v-equinix-configured/equinix"
  version         = "1.0.0"

  metro_code      = "NY"
  core_count      = 2
  device_name     = "tf-csr1000v-p"
  device_hostname = "csr1000v-primary"
  notifications   = ["myemail@equinix.com"]
  create_acl      = true
  create_ssh_user = true
  ssh_username    = "csradmin1"
  ssh_password    = "Cisco123"
}

output "ssh_ip_address"{
    value = module.csr1000v.network_device.ssh_ip_address
}

output "ssh_username"{
    value = module.csr1000v.ssh_user.username
}

output "ssh_password"{
    value = module.csr1000v.ssh_user.password
    sensitive = true
}
```

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/bayupw/terraform-equinix-csr1000v-equinix-configured/issues/new) section.

## License

Apache 2 Licensed. See [LICENSE](https://github.com/bayupw/terraform-equinix-csr1000v-equinix-configured/tree/master/LICENSE) for full details.