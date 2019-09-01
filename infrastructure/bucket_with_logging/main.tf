resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "${var.namespace}"
  region = "${var.region}"
  logging {
      target_bucket = "${module.logging_bucket.bucket.id}"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3600
  }

  tags = "${var.tags}"
  force_destroy = true

}

module "logging_bucket" {
  source    = "github.com/officer/terraform-logging-bucket.git"
  region    = "${var.region}"
  namespace = "${var.namespace}"
  tags      = "${var.tags}"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = "${aws_s3_bucket.bucket.id}"
  policy = "${var.bucket_policy}"
}
