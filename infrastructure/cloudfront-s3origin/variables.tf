
variable "domain_name" {
  description = "CloudFront CNAME Domain name"
  type = "string"
}

variable "s3_domain" {
  description = "S3 content bucket domain name"
  type = "string"
}

variable "s3_region" {
  description = "The region s3 logging bucket belongs to "
  type = "string"
  default = "us-east-1"
}


variable "origin_access_identity" {
  description = "Origin Access Identity Object"
  type = "map"
}


variable "certificate_arn" {
  description = "ACM Certificate ARN"
  type = "string"
}

variable "zone_id" {
  description = "Hosted zone id"
  type = "string"
}


variable "namespace" {
  description = "Namespace for the resources"
  type = "string"
}

variable "tags" {
  description = "Tags for resource"
  type = "map"
}
