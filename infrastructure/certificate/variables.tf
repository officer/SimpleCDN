variable "region" {
  description = "Region"
  type = "string"
}


variable "zone_id" {
  description = "Route53 Hosted zone id"
  type = "string"
}

variable "domain_name" {
  description = "CloudFront Domain name"
  type = "string"
}

variable "tags" {
  description = "Tags for resource"
  type = "map"
}