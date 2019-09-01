output "content_bucket" {
  value = "${aws_s3_bucket.bucket}"
}

output "logging_bucket" {
  value = "${module.logging_bucket.bucket}"
}

