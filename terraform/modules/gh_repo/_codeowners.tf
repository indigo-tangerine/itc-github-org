resource "github_team" "codeowners" {
  name        = "${var.group_name}-codeowners"
  description = "Code Owners for ${var.group_name}"
  privacy     = "closed"
}

resource "github_team_membership" "codeowners" {
  for_each = toset(var.codeowners)
  team_id  = github_team.codeowners.id
  username = each.value
  role     = "member"
}

