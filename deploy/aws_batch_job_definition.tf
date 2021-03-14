resource "aws_batch_job_definition" "csv_processor" {
  name = "batch_csv_processor"
  type = "container"
  retry_strategy {
    attempts = 5
  }
  parameters = {
    "bucket" = "irs-form-990"   # bucket name
    "path"   = "index_2017.csv" # objectname
  }
  container_properties = <<EOF
{
    "command": ["Ref::bucket", "Ref::path"],
    "image": "${aws_ecr_repository.docker_repo.repository_url}:${var.image_tag}",
    "memory": 1024,
    "vcpus": 1,
    "ulimits": [
      {
        "hardLimit": 1024,
        "name": "nofile",
        "softLimit": 1024
      }
    ],
    "jobRoleArn": "${aws_iam_role.task_role.arn}"
}
EOF
}
