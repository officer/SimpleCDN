data "aws_iam_policy_document" "bucket_policy" {
  statement {
      effect = "Allow"
      actions = ["s3:GetObject"]
      resources = [
          "${var.bucket_arn}/*"
      ]
      principals {
          type = "CanonicalUser"
          identifiers = [
              "${var.origin_access_identity.s3_canonical_user_id}"
          ]
      }
  }
}
