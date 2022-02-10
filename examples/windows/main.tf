locals {
  environment = "prebuilt"
  aws_region  = "us-east-1"
}

resource "random_id" "random" {
  byte_length = 20
}

data "aws_caller_identity" "current" {}

module "runners" {
  source = "../../"

  aws_region  = local.aws_region
  vpc_id      = "vpc-0a904ee33e2d58b26"
  subnet_ids  = ["subnet-0981d6a88a60da512"]
  environment = local.environment
  runner_additional_security_group_ids = ["sg-00399ed3145c5d274"]

  github_app = {
    key_base64     = var.github_app_key_base64
    id             = var.github_app_id
    webhook_secret = random_id.random.hex
  }

  # Grab the lambda packages from local directory. Must run /.ci/build.sh first
  webhook_lambda_zip                = "lambdas-download/webhook.zip"
  runner_binaries_syncer_lambda_zip = "lambdas-download/runner-binaries-syncer.zip"
  runners_lambda_zip                = "lambdas-download/runners.zip"

  enable_organization_runners = false
  # no need to add extra windows tag here as it is automatically added by GitHub
  runner_extra_labels = "default,example"

  # Set the OS to Windows
  runner_os = "windows"
  # we need to give the runner time to start because this is windows.
  runner_boot_time_in_minutes = 20
  runner_number_of_runners = 2

  runners_maximum_count = 4

  # configure your pre-built AMI
  enabled_userdata = true
  ami_filter       = { name = [var.ami_name_filter] }
  ami_owners       = [data.aws_caller_identity.current.account_id]

  # enable access to the runners via SSM
  enable_ssm_on_runners = true

  instance_types = ["t3.medium"]
  instance_target_capacity_type = "on-demand"

  # override delay of events in seconds for testing
  delay_webhook_event = 5

  # override scaling down for testing
  scale_down_schedule_expression = "cron(*/5 * * * ? *)"
}
