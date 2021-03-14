variable "region" {
  type        = string
  description = "AWS Region to deploy into"
  default     = "us-east-1"
}

variable "image_tag" {
  type        = string
  description = "Container image tag"
  default     = "latest"
}

variable "image_name" {
  type        = string
  description = "Image name for the container"
  default     = "csv_processor"
}

variable "vpc_id" {
  description = "VPC ID to deploy into"
  type        = string
}

variable "security_group_ids" {
  description = "Security Group IDs"
  type        = list(string)
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name containing data files"
}

variable "object_path_and_name" {
  type        = string
  description = "S3 object path and name"
}
