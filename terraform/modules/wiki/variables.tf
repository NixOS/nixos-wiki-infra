variable "admin_ssh_keys" {
  type = map(string)
  description = "SSH public keys for admin user (name -> key)"
}

variable "server_type" {
  type = string
  default = "cx21"
  description = "Hetzner cloud server type"
}

variable "server_location" {
  type = string
  default = "hel1"
  description = "Hetzner cloud server location"
}

variable "netlify_dns_zone" {
  type = string
  description = "Netlify DNS zone"
}

variable "nixos_vars_file" {
  type = string
  description = "File to write NixOS configuration variables to"
}

variable "nixos_flake_attr" {
  type = string
  description = "NixOS configuration flake attribute"
}

variable "domain" {
  type = string
  description = "Domain name"
}

variable "tags" {
  type = map(string)
  default = {}
  description = "Tags to add to the server"
}
