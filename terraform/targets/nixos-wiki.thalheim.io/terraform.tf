terraform {
  backend "http" {
    address        = "https://gitlab.com/api/v4/projects/45776186/terraform/state/nixos-wiki.thalheim.io"
    lock_address   = "https://gitlab.com/api/v4/projects/45776186/terraform/state/nixos-wiki.thalheim.io/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/45776186/terraform/state/nixos-wiki.thalheim.io/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = "5"
  }
}

module "wiki" {
  source = "${path.module}/../../modules/nixos-wiki.thalheim.io"
  admin_ssh_keys = {
    mic92 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKbBp2dH2X3dcU1zh+xW3ZsdYROKpJd3n13ssOP092qE joerg@turingmachine"
  }
  netlify_dns_zone = "wiki.thalheim.io"
  nixos_flake_attr = "nixos-wiki-production"
  nixos_vars_file = "${path.module}/nixos-vars.json"
}
