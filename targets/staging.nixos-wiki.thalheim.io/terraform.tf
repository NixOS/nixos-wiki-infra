terraform {
  backend "http" {
    address        = "https://gitlab.com/api/v4/projects/45776186/terraform/state/staging.nixos-wiki.thalheim.io"
    lock_address   = "https://gitlab.com/api/v4/projects/45776186/terraform/state/staging.nixos-wiki.thalheim.io/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/45776186/terraform/state/staging.nixos-wiki.thalheim.io/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = "5"
  }
}

module "wiki" {
  source           = "../../terraform/nixos-wiki"
  netlify_dns_zone = "nixos-wiki.thalheim.io"
  nixos_flake_attr = "nixos-wiki-thalheim-io"
  nixos_vars_file  = "${path.module}/nixos-vars.json"
  tags = {
    Terraform = "true"
    Target    = "staging-nixos-wiki.thalheim.io"
  }
}
