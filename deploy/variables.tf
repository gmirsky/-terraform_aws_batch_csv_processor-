variable "region" {
  default     = "us-east-1"
  description = "AWS Region to deploy into"
  type        = string
}

variable "image_tag" {
  default     = "latest"
  description = "Container image tag"
  type        = string
}

variable "image_name" {
  default     = "csv_processor"
  description = "Image name for the container"
  type        = string
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
  description = "S3 bucket name containing data files"
  type        = string
}

variable "object_path_and_name" {
  description = "S3 object path and name"
  type        = string
}

variable "tags" {
  default     = {}
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
}

variable "environment" {
  default     = "DEV"
  description = "Environment for service"
  type        = string
}

variable "bid_percentage" {
  default     = 75
  description = "Integer of minimum percentage that a Spot Instance price must be compared with the On-Demand price for that instance type before instances are launched."
  type        = number
}

variable "instance_type" {
  type        = list(string)
  description = "Batch Compute Environment instance types"
  default = [
    "m4",
    "m5"
  ]
}
