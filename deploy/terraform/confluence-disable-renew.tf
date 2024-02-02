# Job Definition
resource "aws_batch_job_definition" "generate_batch_jd_disable_renew" {
  name                  = "${var.prefix}-disable-renew"
  type                  = "container"
  container_properties  = <<CONTAINER_PROPERTIES
  {
    "image": "${local.account_id}.dkr.ecr.us-west-2.amazonaws.com/${var.prefix}-disable-renew",
    "executionRoleArn": "${data.aws_iam_role.exe_role.arn}",
    "jobRoleArn": "${data.aws_iam_role.job_role.arn}",
    "fargatePlatformConfiguration": { "platformVersion": "LATEST" },
    "logConfiguration": {
      "logDriver" : "awslogs",
      "options": {
        "awslogs-group" : "${data.aws_cloudwatch_log_group.cw_log_group.name}"
      }
    },
    "resourceRequirements": [
      {"type": "MEMORY", "value": "512"},
      {"type": "VCPU", "value": "0.25"}
    ]
  }
  CONTAINER_PROPERTIES
  platform_capabilities = ["FARGATE"]
  propagate_tags        = true
  tags = { "job_definition": "${var.prefix}-disable-renew" }
}
