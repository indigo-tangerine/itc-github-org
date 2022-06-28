provider "github" {
  owner = "indigo-tangerine"
  app_auth {
    installation_id = var.github_installation_id
    id              = var.github_app_id
    pem_file        = var.github_pem_file
  }
}

provider "aws" {
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]
  assume_role {
    role_arn     = local.aws_provider_assume_role_arn
    session_name = "${var.github_actions_session_name}Terraform"
    external_id  = var.aws_role_external_id
  }
  default_tags {
    tags = local.default_tags
  }
}
