# Record the SSH public key into Hetzner Cloud
data "hcloud_ssh_keys" "nixos_wiki" {
  with_selector = "wiki=true"
}

resource "hcloud_server" "nixos_wiki" {
  image       = "debian-11"
  keep_disk   = true
  name        = "nixos-wiki"
  server_type = var.server_type
  ssh_keys    = data.hcloud_ssh_keys.nixos_wiki.ssh_keys.*.name
  backups     = false
  labels      = var.tags

  delete_protection  = true
  rebuild_protection = true

  location = var.server_location

  lifecycle {
    # Don't destroy server instance if ssh keys changes.
    ignore_changes  = [ssh_keys]
    prevent_destroy = true
  }
}

resource "hcloud_rdns" "nixos_wiki_v4" {
  server_id  = hcloud_server.nixos_wiki.id
  ip_address = hcloud_server.nixos_wiki.ipv4_address
  dns_ptr    = coalesce(var.ptr_hostname, var.domain)
}

resource "hcloud_rdns" "nixos_wiki_v6" {
  server_id  = hcloud_server.nixos_wiki.id
  ip_address = hcloud_server.nixos_wiki.ipv6_address
  dns_ptr    = coalesce(var.ptr_hostname, var.domain)
}

module "deploy" {
  depends_on             = [local_file.nixos_vars]
  source                 = "github.com/numtide/nixos-anywhere//terraform/all-in-one"
  nixos_system_attr      = ".#nixosConfigurations.${var.nixos_flake_attr}.config.system.build.toplevel"
  nixos_partitioner_attr = ".#nixosConfigurations.${var.nixos_flake_attr}.config.system.build.diskoScriptNoDeps"
  target_host            = hcloud_server.nixos_wiki.ipv4_address
  instance_id            = hcloud_server.nixos_wiki.id
  extra_files_script     = "${path.module}/decrypt-age-keys.sh"
  extra_environment = {
    SOPS_FILE = var.sops_file
  }
  debug_logging = true
}

locals {
  nixos_vars = {
    ipv6_address = hcloud_server.nixos_wiki.ipv6_address
    ssh_keys     = data.hcloud_ssh_keys.nixos_wiki.ssh_keys.*.public_key
  }
}

output "ipv4_address" {
  value = hcloud_server.nixos_wiki.ipv4_address
}

output "ipv6_address" {
  value = hcloud_server.nixos_wiki.ipv6_address
}
