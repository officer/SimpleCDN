output "content_bucket" {
  value = "${aws_s3_bucket.bucket}"
}

output "logging_bucket" {
  value = "${aws_s3_bucket.logging_bucket}"
}

