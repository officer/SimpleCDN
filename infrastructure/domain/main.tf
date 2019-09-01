resource "aws_route53_zone" "domain" {
  lifecycle { 
    prevent_destroy = false
  }
  
  name = "${var.domain_name}"
  tags = "${merge(var.tags, map("Domain", var.domain_name))}"
  force_destroy = true
}
