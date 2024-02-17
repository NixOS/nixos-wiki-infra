terraform {
  backend "http" {
    address        = "https://gitlab.com/api/v4/projects/54760013/terraform/state/nixos-wiki2.thalheim.io"
    lock_address   = "https://gitlab.com/api/v4/projects/54760013/terraform/state/nixos-wiki2.thalheim.io/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/54760013/terraform/state/nixos-wiki2.thalheim.io/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = "5"
  }
}

module "wiki" {
  source           = "../../terraform/nixos-wiki"
  domain           = "nixos-wiki2.thalheim.io"
  nixos_flake_attr = "nixos-wiki-nixos-org"
  nixos_vars_file  = "${path.module}/nixos-vars.json"
  sops_file        = abspath("${path.module}/secrets/secrets.yaml")
  tags = {
    Terraform = "true"
    Target    = "wiki.nixos.org"
  }
}

output "ipv4_address" {
  value = module.wiki.ipv4_address
}

output "ipv6_address" {
  value = module.wiki.ipv6_address
}
