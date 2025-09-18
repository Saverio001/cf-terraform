output "webserver_ip" {
  value       = module.webserver.webserver_ip
  description = "The elastic IP address of the webserver"
}
output "webserver_url" {
  value       = join("", ["http://", var.webserver_name, ".", var.domain1name])
  description = "The webserver's URL"
}

output "cloudflare_dns_domain1" {
  value       = cloudflare_zone.domain1_zone.name_servers
  description = "The two CF nameservers for domain1"
}