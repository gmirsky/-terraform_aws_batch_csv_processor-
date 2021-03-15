resource "aws_ecr_repository" "docker_repo" {
  name = "batch_jobs/${var.image_name}"
  tags = module.aws_user_tags.tags
}
