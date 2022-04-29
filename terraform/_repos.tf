module "tfm_projects" {
  source = "./modules/gh_repo"

  ecr_repositories                     = local.tfm_projects.ecr_repositories
  github_repositories                  = local.tfm_projects.github_repositories
  group_name                           = local.tfm_projects.group_name
  codeowners                           = local.tfm_projects.codeowners
  ecr_get_permissions_allowed_accounts = local.tfm_projects.ecr_get_permissions_allowed_accounts
  ecr_put_permissions_allowed_accounts = local.tfm_projects.ecr_put_permissions_allowed_accounts
  github_org                           = var.github_org
  gh_team_admins_id                    = github_team.admins.id
  gh_team_admins_slug                  = github_team.admins.slug
  gh_team_developers_id                = github_team.developers.id
}

locals {
  tfm_projects = {
    group_name                           = "tfm-projects"
    codeowners                           = []
    ecr_get_permissions_allowed_accounts = [data.aws_caller_identity.current.account_id]
    ecr_put_permissions_allowed_accounts = [data.aws_caller_identity.current.account_id]
    ecr_repositories                     = {}
    github_repositories = {
      itc-aws-base-cfg = {
        codeowners                    = "* @${var.github_org}/tfm-projects-codeowners"
        description                   = "ITC - Base AWS Account Config"
        required_pull_request_reviews = { pull_request_bypassers = [github_team.admins.node_id] }
      },
      itc-tfm-project-template = {
        codeowners                    = "* @${var.github_org}/tfm-projects-codeowners"
        description                   = "ITC - Terraform Project Template"
        required_pull_request_reviews = { pull_request_bypassers = [github_team.admins.node_id] }
      },
      itc-tfm-module-template = {
        codeowners                    = "* @${var.github_org}/tfm-projects-codeowners"
        description                   = "ITC - Terraform Module Template"
        required_pull_request_reviews = { pull_request_bypassers = [github_team.admins.node_id] }
      }
    }
  }
}
