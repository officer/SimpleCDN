output "policy" {
  value = "${data.aws_iam_policy_document.bucket_policy.json}"
}
