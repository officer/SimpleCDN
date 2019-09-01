variable "region" {
  description = "Region"
  type = "string"
}

variable "namespace" {
  description = "Name space for bucket"
  type = "string"
}

variable "tags" {
  description = "tags"
  type = "map"
}

variable "bucket_policy" {
  description = "Bucket policy"
  type = "string"
}

