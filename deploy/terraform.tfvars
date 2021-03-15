region = "us-east-1"
vpc_id = "vpc-57b7b733"
security_group_ids = [
  "sg-5e553926"
]
bucket_name          = "irs-form-990"   #"my-s3-bucket-name-goes-here"
object_path_and_name = "index_2017.csv" #"path/in/bucket/to/object.csv"
environment          = "DEV"
tags = {
  cost-center = "00-000-0000-1"
  project     = "AWS Batch Sample"
}