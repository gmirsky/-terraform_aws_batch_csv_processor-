resource "aws_codebuild_project" "build" {
  name           = "aws_batch_csv_processor"
  description    = "AWS Batch-based CSV processor"
  build_timeout  = "5"
  queued_timeout = "5"
  service_role   = aws_iam_role.codebuild_role.arn
  artifacts {
    type = "NO_ARTIFACTS"
  }
  cache {
    type = "LOCAL"
    modes = [
      "LOCAL_DOCKER_LAYER_CACHE",
      "LOCAL_SOURCE_CACHE"
    ]
  }
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.image_name
    }
    environment_variable {
      name  = "IMAGE_TAG"
      value = var.image_tag
    }
    environment_variable {
      name  = "IMAGE_REPOSITORY_URL"
      value = aws_ecr_repository.docker_repo.repository_url
    }
  }
  source {
    type     = "CODECOMMIT"
    location = aws_codecommit_repository.code_repo.clone_url_http
  }
  tags = module.aws_user_tags.tags
}
