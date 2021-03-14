resource "aws_codecommit_repository" "code_repo" {
  repository_name = "aws_batch_csv_processor"
  description     = "AWS Batch processor of CSV code repository"
}
