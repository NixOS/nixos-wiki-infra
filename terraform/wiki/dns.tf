resource "netlify_dns_zone" "nixos" {
  site_id = ""
  name    = var.netlify_dns_zone
}

resource "netlify_dns_record" "nixos_wiki_a" {
  zone_id  = netlify_dns_zone.nixos.id
  hostname = var.domain
  type     = "A"
  value    = hcloud_server.nixos_wiki.ipv4_address
}

resource "netlify_dns_record" "nixos_wiki_aaaa" {
  zone_id  = netlify_dns_zone.nixos.id
  hostname = var.domain
  type     = "AAAA"
  value    = hcloud_server.nixos_wiki.ipv6_address
}
