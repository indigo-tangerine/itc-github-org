# Common data resources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "github_team" "admins" {
  slug = "admins"
}
