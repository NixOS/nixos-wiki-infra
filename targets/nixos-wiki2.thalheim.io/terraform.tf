terraform {
  backend "http" {
    address        = "https://gitlab.com/api/v4/projects/45776186/terraform/state/nixos-wiki2.thalheim.io"
    lock_address   = "https://gitlab.com/api/v4/projects/45776186/terraform/state/nixos-wiki2.thalheim.io/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/45776186/terraform/state/nixos-wiki2.thalheim.io/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = "5"
  }
}

module "wiki" {
  source           = "../../terraform/nixos-wiki"
  netlify_dns_zone = "nixos-wiki2.thalheim.io"
  domain           = "nixos-wiki2.thalheim.io"
  nixos_flake_attr = "nixos-wiki2-thalheim-io"
  nixos_vars_file  = "${path.module}/nixos-vars.json"
  tags = {
    Terraform = "true"
    Target    = "nixos-wiki2.thalheim.io"
  }
}
