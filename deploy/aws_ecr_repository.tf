resource "aws_ecr_repository" "docker_repo" {
  name = var.image_name
  tags = module.aws_user_tags.tags
}
