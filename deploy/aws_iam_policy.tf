resource "aws_iam_policy" "codebuild_policy" {
  name        = "codebuild-policy"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"
  policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "codecommit:GitPull",
        "ecr:GetAuthorizationToken",
	    "ecr:BatchCheckLayerAvailability",
		"ecr:GetDownloadUrlForLayer",
		"ecr:GetRepositoryPolicy",
		"ecr:DescribeRepositories",
		"ecr:ListImages",
		"ecr:DescribeImages",
		"ecr:BatchGetImage",
		"ecr:InitiateLayerUpload",
		"ecr:UploadLayerPart",
		"ecr:CompleteLayerUpload",
		"ecr:PutImage"
      ]
    }
  ]
}
POLICY
}
