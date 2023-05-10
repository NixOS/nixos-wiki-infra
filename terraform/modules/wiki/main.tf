# Record the SSH public key into Hetzner Cloud
resource "hcloud_ssh_key" "hcloud" {
  for_each   = var.admin_ssh_keys
  name       = "${var.domain}-${each.key}"
  public_key = each.value
}

resource "hcloud_server" "nixos_wiki" {
  image       = "debian-10"
  keep_disk   = true
  name        = "nixos-wiki"
  server_type = var.server_type
  ssh_keys    = [for k in hcloud_ssh_key.hcloud : k.id]
  backups     = false
  labels      = var.tags

  location = var.server_location

  lifecycle {
    # Don't destroy server instance if ssh keys changes.
    ignore_changes  = [ssh_keys]
    prevent_destroy = false
  }
}

module "deploy" {
  depends_on             = [local_file.nixos_vars]
  source                 = "github.com/numtide/nixos-anywhere//terraform/all-in-one"
  nixos_system_attr      = ".#nixosConfigurations.${var.nixos_flake_attr}.config.system.build.toplevel"
  nixos_partitioner_attr = ".#nixosConfigurations.${var.nixos_flake_attr}.config.system.build.diskoNoDeps"
  target_host            = hcloud_server.nixos_wiki.ipv4_address
  instance_id            = hcloud_server.nixos_wiki.id
  debug_logging          = true
}

locals {
  nixos_vars = {
    ipv6_address = hcloud_server.nixos_wiki.ipv6_address
  }
}
