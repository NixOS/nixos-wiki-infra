variable "server_type" {
  type        = string
  default     = "cx42"
  description = "Hetzner cloud server type"
}

variable "server_location" {
  type        = string
  default     = "hel1"
  description = "Hetzner cloud server location"
}

variable "nixos_vars_file" {
  type        = string
  description = "File to write NixOS configuration variables to"
}

variable "sops_file" {
  type        = string
  description = "File to SOPS secrets file"
}

variable "nixos_flake_attr" {
  type        = string
  description = "NixOS configuration flake attribute"
}

variable "domain" {
  type        = string
  description = "Domain name"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to add to the server"
}

variable "ptr_hostname" {
  type        = string
  default     = null
  description = "Reverse DNS name for the server addresses. Must resolve back to the server (FCrDNS) for mail delivery; defaults to domain."
}
