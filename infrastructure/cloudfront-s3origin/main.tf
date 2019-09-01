locals {
  origin_id = "${var.namespace}-s3origin"
}


# CloudFront
resource "aws_cloudfront_distribution" "distribution" {
    default_root_object = "index.html"
    enabled             = true
    viewer_certificate  {
      acm_certificate_arn = "${var.certificate_arn}"
      ssl_support_method  = "vip"
    }
    aliases             = ["${var.domain_name}"]
    is_ipv6_enabled     = true
    

    origin {
      domain_name             = "${var.s3_domain}"
      origin_id               = "${local.origin_id}"
      s3_origin_config {
        origin_access_identity = "${var.origin_access_identity.cloudfront_access_identity_path}"
      }
    }

    default_cache_behavior {
      allowed_methods   = ["GET", "HEAD", "OPTIONS"]
      cached_methods     = ["GET", "HEAD", "OPTIONS"]
      target_origin_id  = "${local.origin_id}"

      viewer_protocol_policy = "redirect-to-https"
      min_ttl                = 0
      default_ttl            = 3600
      max_ttl                = 86400
      forwarded_values {
        query_string = false

        cookies {
          forward = "none"
        }
      }
    }

    restrictions {
      geo_restriction {
        restriction_type = "none"
      }
    }

    logging_config {
      include_cookies = true
      bucket = "${aws_s3_bucket.access_log_bucket.bucket_domain_name}"
    }

}

# A Record
resource "aws_route53_record" "record" {
  zone_id = "${var.zone_id}"
  name    = "${var.domain_name}"
  type    = "A"
  alias {
    name                    = "${aws_cloudfront_distribution.distribution.domain_name}"
    zone_id                 = "${aws_cloudfront_distribution.distribution.hosted_zone_id}"
    evaluate_target_health  = true
  }
}


## S3 Bucket for CF logging
resource "aws_s3_bucket" "access_log_bucket" {
  bucket_prefix = "${var.namespace}-access-log-bucket"
  acl           = "log-delivery-write"
}