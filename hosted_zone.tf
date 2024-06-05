locals {
  subdomain = "${var.instance}.${var.cluster_domain}"
}

data "aws_route53_zone" "top_level_domain" {
  name = var.cluster_domain
}

module "instance_hosted_zone" {
  source  = "registry.terraform.io/terraform-aws-modules/route53/aws//modules/zones"
  version = "2.0.0"

  zones = {
    "${local.subdomain}" = {
      comment = "hosted zone for ${var.instance} subdomain"
    }
  }
}

resource "aws_route53_record" "instance_hosted_zone_delegation" {
  zone_id         = data.aws_route53_zone.top_level_domain.zone_id
  name            = local.subdomain
  type            = "NS"
  ttl             = 172800
  allow_overwrite = true
  records         = module.instance_hosted_zone.route53_zone_name_servers[local.subdomain]
}
