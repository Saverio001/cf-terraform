resource "cloudflare_zone" "domain1_zone" {
  account = {
    id = var.cloudflare_account_id
  }
  name = var.domain1name
}

resource "cloudflare_dns_record" "webserver_origin1" {
  zone_id = cloudflare_zone.domain1_zone.id
  name    = var.webserver_name
  ttl     = 1
  type    = "A"
  comment = "Webserver"
  content = module.webserver.webserver_ip
  proxied = true

}

#resource "cloudflare_zone" "domain2_zone" {
#  account = {
#    id = var.cloudflare_account_id
#  }
#  name = var.domain2name
#  type = "partial"
#}
