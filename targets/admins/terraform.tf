terraform {
  backend "http" {
    address        = "https://gitlab.com/api/v4/projects/45776186/terraform/state/admins"
    lock_address   = "https://gitlab.com/api/v4/projects/45776186/terraform/state/admins/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/45776186/terraform/state/admins/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = "5"
  }
}

module "wiki" {
  source = "../../terraform/admins"
  ssh_keys = {
    mic92  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKbBp2dH2X3dcU1zh+xW3ZsdYROKpJd3n13ssOP092qE joerg@turingmachine"
    julien = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDMBW7rTtfZL9wtrpCVgariKdpN60/VeAzXkh9w3MwbO julien@enigma"
  }
}
