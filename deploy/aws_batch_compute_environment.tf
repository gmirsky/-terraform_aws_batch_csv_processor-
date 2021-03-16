resource "aws_batch_compute_environment" "compute" {
  compute_environment_name = "spot_mx_class_${data.aws_caller_identity.current.account_id}"
  compute_resources {
    instance_role       = aws_iam_instance_profile.ecs_instance_role.arn
    instance_type       = var.instance_type
    max_vcpus           = 16
    min_vcpus           = 0
    security_group_ids  = var.security_group_ids
    subnets             = data.aws_subnet_ids.subnets.ids
    type                = "SPOT"
    bid_percentage      = var.bid_percentage
    spot_iam_fleet_role = aws_iam_role.spot_fleet_role.arn
  }
  service_role = aws_iam_role.aws_batch_service_role.arn
  type         = "MANAGED"
  depends_on = [
    aws_iam_role_policy_attachment.aws_batch_service_role
  ]
  tags = module.aws_user_tags.tags
}
