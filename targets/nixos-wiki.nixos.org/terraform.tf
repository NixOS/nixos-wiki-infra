variable "passphrase" {}

terraform {
  encryption {
    key_provider "pbkdf2" "sops" {
      passphrase = var.passphrase
    }

    method "aes_gcm" "sops" {
      keys = key_provider.pbkdf2.sops
    }

    state {
      method   = method.aes_gcm.sops
      enforced = true
    }
  }
}

module "wiki" {
  source           = "../../terraform/nixos-wiki"
  domain           = "wiki.nixos.org"
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
