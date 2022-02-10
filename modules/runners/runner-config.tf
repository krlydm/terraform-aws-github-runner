resource "aws_ssm_parameter" "runner_config_run_as" {
  name  = "/${var.environment}/runner/run-as"
  type  = "String"
  value = var.runner_as_root ? "root" : var.runner_run_as
  tags  = local.tags
}

resource "aws_ssm_parameter" "runner_config_number_of_runners" {
  name  = "/${var.environment}/runner/number_of_runners"
  type  = "String"
  value = var.runner_number_of_runners
  tags  = local.tags
}

resource "aws_ssm_parameter" "runner_agent_mode" {
  name  = "/${var.environment}/runner/agent-mode"
  type  = "String"
  value = var.enable_ephemeral_runners ? "ephemeral" : "persistent"
  tags  = local.tags
}

resource "aws_ssm_parameter" "runner_enable_cloudwatch" {
  name  = "/${var.environment}/runner/enable-cloudwatch"
  type  = "String"
  value = var.enable_cloudwatch_agent
  tags  = local.tags
}
