# Common data resources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "github_user" "approvers" {
  for_each = local.user_names

  username = each.value
}

data "github_team" "approvers" {
  for_each = local.team_names

  slug = each.value
}
