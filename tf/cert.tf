resource "aws_acm_certificate" "public_alb" {
  domain_name = "softphusion.com"
  subject_alternative_names = ["*.softphusion.com"]
  validation_method = "DNS"
}

#resource "aws_acm_certificate_validation" "public_alb" {
#  certificate_arn         = aws_acm_certificate.this.arn
#  validation_record_fqdns = aws_route53_record.this.*.fqdn
#}

data "aws_route53_zone" "public_alb" {
  name         = "softphusion.com"
  private_zone = false
}

resource "aws_route53_record" "public_alb" {
  zone_id = data.aws_route53_zone.public_alb.zone_id
  name    = "lets-chat.softphusion.com"
  type    = "A"
  allow_overwrite = true # This is what allowed for conflict resolution in DNS

  alias {
    name                   = aws_lb.mightyreal_public_alb.dns_name
    zone_id                = aws_lb.mightyreal_public_alb.zone_id
    evaluate_target_health = true
  }
}
