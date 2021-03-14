output "repo_ssh_url" {
  value = aws_codecommit_repository.code_repo.clone_url_ssh
}
