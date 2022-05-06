# # Create the repositories
#tfsec:ignore:github-repositories-private
resource "github_repository" "main" {
  for_each = var.github_repositories

  name                   = each.key
  homepage_url           = try(each.value.homepage_url, "https://github.com/${var.github_org}")
  visibility             = try(each.value.visibility, "public")
  has_issues             = try(each.value.has_issues, false)
  has_projects           = try(each.value.has_projects, false)
  has_wiki               = try(each.value.has_wiki, false)
  allow_merge_commit     = try(each.value.allow_merge_commit, true)
  allow_rebase_merge     = try(each.value.allow_rebase_merge, false)
  allow_squash_merge     = try(each.value.allow_squash_merge, true)
  allow_auto_merge       = try(each.value.allow_auto_merge, true)
  delete_branch_on_merge = try(each.value.delete_branch_on_merge, true)
  is_template            = try(each.value.is_template, false)
  has_downloads          = try(each.value.has_downloads, true)
  auto_init              = true
  gitignore_template     = try(each.value.gitignore_template, "Terraform")
  archive_on_destroy     = try(each.value.archive_on_destroy, true)
  vulnerability_alerts   = try(each.value.vulnerability_alerts, true)
  description            = try(each.value.description, each.key)

  dynamic "pages" {
    // for_each = try(each.value.enable_pages, false) ? each.value.pages : {}
    for_each = try(each.value.pages, {}) != {} ? each.value.pages : {}
    content {
      source {
        branch = each.value.pages.source.branch
        path   = each.value.pages.source.path
      }
    }
  }

  dynamic "template" {
    for_each = try(each.value.create_from_template, {}) != {} ? each.value.create_from_template : {}
    content {
      owner      = try(each.value.create_from_template.owner, var.github_org)
      repository = each.value.create_from_template.repository
    }
  }
}

resource "github_repository_environment" "main" {
  for_each = local.stages_by_stage_and_repo

  environment = each.value.stage_name
  repository  = each.value.repository_name

  reviewers {
    users = [for approval_name in each.value.approvals_users : data.github_user.approvers[approval_name].id]
    teams = [for approval_name in each.value.approvals_teams : data.github_team.approvers[approval_name].id]
  }

  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }

  depends_on = [
    github_repository.main
  ]
}

# Set the default branch for the repositories

resource "github_branch_default" "main" {
  for_each = var.github_repositories

  repository = each.key
  branch     = try(each.value.default_branch, "main")

  depends_on = [
    github_repository.main
  ]
}

# Setting up the branch protection settings

resource "github_branch_protection" "main" {
  for_each = var.github_repositories

  repository_id = github_repository.main[each.key].id

  pattern          = "main"
  enforce_admins   = false
  allows_deletions = false

  required_status_checks {
    strict   = try(each.value.required_status_checks.strict, null)
    contexts = try(each.value.required_status_checks.contexts, null)
  }

  required_pull_request_reviews {
    restrict_dismissals             = try(each.value.required_pull_request_reviews.restrict_dismissals, true)
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = try(each.value.required_pull_request_reviews.required_approving_review_count, 2)
    pull_request_bypassers = try(concat(each.value.required_pull_request_reviews.pull_request_bypassers,
      [github_team.codeowners.node_id, var.gh_team_admins_node_id]),
    [github_team.codeowners.node_id, var.gh_team_admins_node_id])
  }

  depends_on = [
    github_repository.main, github_branch_default.main
  ]
}

resource "github_branch_protection" "development_branch" {
  for_each = var.github_repositories

  repository_id = github_repository.main[each.key].id

  pattern          = "develop"
  enforce_admins   = false
  allows_deletions = false

  # required_status_checks {
  #   strict   = false
  #   contexts = try(each.value.protection.contexts, ["ci"])
  # }

  required_pull_request_reviews {
    restrict_dismissals             = try(each.value.required_pull_request_reviews.restrict_dismissals, false)
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = try(each.value.required_pull_request_reviews.develop_branch_require_code_owner_reviews, false)
    required_approving_review_count = try(each.value.required_pull_request_reviews.develop_branch_required_approving_review_count, 1)
  }

  depends_on = [
    github_repository.main, github_branch_default.main
  ]
}

resource "github_branch_protection" "release_branches" {
  for_each = var.github_repositories

  repository_id = github_repository.main[each.key].id

  pattern          = "release*"
  enforce_admins   = false
  allows_deletions = false

  # required_status_checks {
  #   strict   = false
  #   contexts = try(each.value.protection.contexts, ["ci"])
  # }

  required_pull_request_reviews {
    restrict_dismissals             = try(each.value.required_pull_request_reviews.restrict_dismissals, false)
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = try(each.value.required_pull_request_reviews.release_branch_require_code_owner_reviews, false)
    required_approving_review_count = try(each.value.required_pull_request_reviews.release_branch_required_approving_review_count, 2)
  }

  depends_on = [
    github_repository.main, github_branch_default.main
  ]
}

# Linking the teams to the repository

resource "github_team_repository" "admins_team" {
  for_each = var.github_repositories

  team_id    = var.gh_team_admins_id
  repository = each.key
  permission = "admin"

  depends_on = [github_repository.main]

}

resource "github_team_repository" "developers" {
  for_each = var.github_repositories

  team_id    = var.gh_team_developers_id
  repository = each.key
  permission = "push"

  depends_on = [github_repository.main]

}

resource "github_team_repository" "codeowners" {
  for_each = var.github_repositories

  team_id    = github_team.codeowners.id
  repository = each.key
  permission = "push"

  depends_on = [github_repository.main]

}

# Important - after creation any changes to CODEOWNERS should be made in the repo, NOT here

resource "github_repository_file" "codeowners_file" {
  for_each            = var.github_repositories
  repository          = each.key
  commit_message      = "Editing CODEOWNERS file - Managed by Terraform"
  commit_author       = "github-svc"
  commit_email        = "github-svc@${var.github_org}.com"
  branch              = try(each.value.default_branch, "main")
  file                = "CODEOWNERS"
  content             = try(each.value.codeowners, "* @${var.github_org}/${var.gh_team_admins_slug},@${var.github_org}/${github_team.codeowners.slug}")
  overwrite_on_create = true
  depends_on          = [github_repository.main, github_branch_default.main, github_team_repository.admins_team]
}
