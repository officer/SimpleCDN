resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "${var.namespace}"
  region = "${var.region}"
  logging {
      target_bucket = "${aws_s3_bucket.logging_bucket.id}"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3600
  }

  tags = "${var.tags}"
  force_destroy = true

  depends_on = ["aws_s3_bucket.logging_bucket"]
}

resource "aws_s3_bucket" "logging_bucket" {
  region        = "${var.region}"
  bucket_prefix = "${var.namespace}-logging-"
  acl           = "log-delivery-write"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = "${aws_s3_bucket.bucket.id}"
  policy = "${var.bucket_policy}"
}
