locals {
  aws_account_id = data.aws_caller_identity.current.account_id

  # # adding the environments
  stages = flatten([
    for repository_name, repository in var.github_repositories : [
      for stage_name, approvals in try(repository.environments, {}) : {
        repository_name = repository_name
        stage_name      = stage_name
        approvals_users = try(approvals.users, [])
        approvals_teams = try(approvals.teams, [])
      }
    ]
  ])
  stage_ids                = [for stage in local.stages : "${stage.repository_name}-${stage.stage_name}"]
  stages_by_stage_and_repo = zipmap(local.stage_ids, local.stages)
  user_names               = toset(distinct(flatten([for stage_info in local.stages : stage_info.approvals_users])))
  team_names               = toset(distinct(flatten([for stage_info in local.stages : stage_info.approvals_teams])))
}
