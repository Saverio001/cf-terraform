data "aws_route53_zone" "domain1zone" {
  name         = var.domain1name
  private_zone = false
}
resource "aws_route53_record" "webserver_domain1" {
  zone_id = data.aws_route53_zone.domain1zone.zone_id
  name    = join(".", [var.webserver_name, var.domain1name])
  type    = "A"
  ttl     = 300
  records = [module.webserver.webserver_ip]
}


resource "aws_route53_record" "nameservers" {
  allow_overwrite = true
  name            = var.domain1name
  ttl             = 60
  type            = "NS"
  zone_id         = data.aws_route53_zone.domain1zone.zone_id
  records         = cloudflare_zone.domain1_zone.name_servers
}

data "aws_route53_zone" "domain2zone" {
  name         = var.domain2name
  private_zone = false
}

resource "aws_route53_record" "a_webserver_domain2" {
  zone_id = data.aws_route53_zone.domain2zone.zone_id
  name    = join(".", ["internal", var.webserver_name])
  type    = "A"
  ttl     = 300
  records = [module.webserver.webserver_ip]
}

resource "aws_route53_record" "cname_webserver_domain2" {
  zone_id = data.aws_route53_zone.domain2zone.zone_id
  name    = var.webserver_name
  type    = "CNAME"
  ttl     = 300
  records = [join(".", [aws_route53_record.a_webserver_domain2.name, var.domain2name, "cdn.cloudflare.net"])]
}