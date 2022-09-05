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
  gh_team_admins_node_id               = github_team.admins.node_id
  gh_team_admins_slug                  = github_team.admins.slug
  gh_team_developers_id                = github_team.developers.id
}

module "cdk_projects" {
  source = "./modules/gh_repo"

  ecr_repositories                     = local.cdk_projects.ecr_repositories
  github_repositories                  = local.cdk_projects.github_repositories
  group_name                           = local.cdk_projects.group_name
  codeowners                           = local.cdk_projects.codeowners
  ecr_get_permissions_allowed_accounts = local.cdk_projects.ecr_get_permissions_allowed_accounts
  ecr_put_permissions_allowed_accounts = local.cdk_projects.ecr_put_permissions_allowed_accounts
  github_org                           = var.github_org
  gh_team_admins_id                    = github_team.admins.id
  gh_team_admins_node_id               = github_team.admins.node_id
  gh_team_admins_slug                  = github_team.admins.slug
  gh_team_developers_id                = github_team.developers.id
}

locals {
  tfm_projects = {
    group_name                           = "tfm-projects"
    codeowners                           = []
    ecr_get_permissions_allowed_accounts = [data.aws_caller_identity.current.account_id]
    ecr_put_permissions_allowed_accounts = [data.aws_caller_identity.current.account_id]
    ecr_repositories = {
      mvdb = {
        image_tag_mutability = "MUTABLE"
      }
      "mvdb-lambda" = {
        image_tag_mutability = "MUTABLE"
      }
    }
    github_repositories = {
      itc-aws-base-cfg = {
        description = "ITC - Base AWS Account Config"
      }
      itc-tfm-project-template = {
        description = "ITC - Terraform Project Template"
        is_template = true
      }
      itc-tfm-module-template = {
        description = "ITC - Terraform Module Template"
        is_template = true
      }
      itc-tfm-mvdb = {
        description = "ITC - Terraform - Movie DB - Lambda"
        create_from_template = {
          repository = "itc-tfm-project-template"
        }
      },
      itc-tfm-mvdb-ecs = {
        description = "ITC - Terraform - Movie DB - ECS"
        create_from_template = {
          repository = "itc-tfm-project-template"
        }
      }
      itc-dkr-mvdb = {
        description = "ITC - Docker - Movie DB"
        create_from_template = {
          repository = "itc-tfm-project-template"
        }
      }
    }
  }

  cdk_projects = {
    group_name                           = "cdk-projects"
    codeowners                           = []
    ecr_get_permissions_allowed_accounts = [data.aws_caller_identity.current.account_id]
    ecr_put_permissions_allowed_accounts = [data.aws_caller_identity.current.account_id]
    ecr_repositories                     = {}
    github_repositories = {
      itc-cdk-pnl-demo = {
        description        = "ITC - PNL CDK Demo"
        gitignore_template = "Node"
      }
      itc-cdk-project-template = {
        description        = "ITC - CDK Project Template"
        is_template        = true,
        gitignore_template = "Node"
      }
    }
  }
}
