locals {
  
  region        = "<region name>"
  profile_name  = "default"
  namespace     = "simple-cdn"

  domain_name   = "<domain name>"

  zone_id       = "<hosted zone id>"

  tags          = "${map(
    "ENV", "TEST"
  )}"
}

# provider definition
provider "aws" {
  version = "~> 2.0"
  region  = "${local.region}"
  profile = "${local.profile_name}"
}

# Origin Access Identity
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "An Origin Access Identity"
}

module "bucket_policy_oai" {
  source                  = "./bucket_policy_origin_access_identity"
  bucket_arn              = "${module.content_bucket.content_bucket.arn}"
  origin_access_identity  = "${aws_cloudfront_origin_access_identity.origin_access_identity}"
}

#S3
module "content_bucket" {
  source    = "./bucket_with_logging"
  region    = "${local.region}"
  namespace = "${local.namespace}"
  bucket_policy  = "${module.bucket_policy_oai.policy}"

  tags      = "${local.tags}"
}

resource "aws_s3_bucket_object" "sample" {
  bucket = "${module.content_bucket.content_bucket.id}"
  key = "index.html"
  source = "../content/index.html"
}

# ACM Certificate
module "certificate" {
  source      = "./certificate"
  region      = "us-east-1"
  zone_id     = "${local.zone_id}"
  domain_name = "${local.domain_name}"
  tags        = "${local.tags}"
}

# CloudFront
module "cloudfront" {
  source                  = "./cloudfront-s3origin"
  domain_name             = "${local.domain_name}"
  s3_domain               = "${module.content_bucket.content_bucket.bucket_regional_domain_name}"
  certificate_arn         = "${module.certificate.certificate_arn}"
  namespace               = "${local.namespace}"
  zone_id                 = "${local.zone_id}"
  tags                    = "${local.tags}"
  origin_access_identity  = "${aws_cloudfront_origin_access_identity.origin_access_identity}"
}