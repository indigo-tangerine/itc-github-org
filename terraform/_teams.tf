# Admins Team
resource "github_team" "admins" {
  name                      = "admins"
  description               = "Administrators team"
  create_default_maintainer = false
  privacy                   = "closed"
}

resource "github_team_membership" "admins_members" {
  for_each = toset(var.admins_team_members)

  team_id  = github_team.admins.id
  username = each.key
  role     = "member"
}

resource "github_team_membership" "admins_maintainers" {
  for_each = toset(var.admins_team_maintainers)

  team_id  = github_team.admins.id
  username = each.key
  role     = "maintainer"
}

# Developers Team
resource "github_team" "developers" {
  name                      = "developers"
  description               = "Developers team"
  create_default_maintainer = false
  privacy                   = "closed"
}

resource "github_team_membership" "developers_members" {
  for_each = toset(var.developers_team_members)

  team_id  = github_team.developers.id
  username = each.key
  role     = "member"
}
