module "tfm_modules" {
  source = "./modules/gh_repo"

  ecr_repositories                     = local.tfm_modules.ecr_repositories
  github_repositories                  = local.tfm_modules.github_repositories
  group_name                           = local.tfm_modules.group_name
  codeowners                           = local.tfm_modules.codeowners
  ecr_get_permissions_allowed_accounts = local.tfm_modules.ecr_get_permissions_allowed_accounts
  ecr_put_permissions_allowed_accounts = local.tfm_modules.ecr_put_permissions_allowed_accounts
  github_org                           = var.github_org
  gh_team_admins_id                    = github_team.admins.id
  gh_team_admins_slug                  = github_team.admins.slug
  gh_team_developers_id                = github_team.developers.id
}

locals {
  tfm_modules = {
    group_name                           = "tfm-mods"
    codeowners                           = []
    ecr_get_permissions_allowed_accounts = [data.aws_caller_identity.current.account_id]
    ecr_put_permissions_allowed_accounts = [data.aws_caller_identity.current.account_id]
    ecr_repositories                     = {}
    github_repositories = {
      terraform-aws-itc-s3 = {
        codeowners  = "* @${var.github_org}/tfm-mods-codeowners"
        description = "Terraform Module - AWS S3"
      }
      terraform-aws-itc-cognito-user-pool = {
        description = "Terraform Module - AWS Cognito User Pool"
      }
    }
  }
}
