resource "local_file" "nixos_vars" {
  content         = jsonencode(local.nixos_vars)
  filename        = var.nixos_vars_file
  file_permission = "600"

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "git add -f '${var.nixos_vars_file}'"
  }
  # also pro-actively add hosts and flake-module.nix to git so nix can find it.
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = <<EOT
git add "$(dirname '${var.nixos_vars_file}')"/{hosts,flake-module.nix}
EOT
    on_failure  = continue
  }
}
