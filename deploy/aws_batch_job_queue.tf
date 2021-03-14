resource "aws_batch_job_queue" "job_queue" {
  name     = "batch_job_queue"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    aws_batch_compute_environment.compute.arn
  ]
  depends_on = [
    aws_batch_compute_environment.compute
  ]
}
