variable "ecr_get_permissions_allowed_accounts" {
  type        = list(any)
  description = "List of AWS accounts allowed to pull from ECR repository"
  default     = []
}

variable "ecr_put_permissions_allowed_accounts" {
  type        = list(any)
  description = "List of AWS accounts allowed to push to ECR repository"
  default     = []
}

variable "ecr_repositories" {
  type        = map(any)
  description = "Map of ECR repository variables"
  default = {
    "ecr-name" = {
      image_tag_mutability = "IMMUTABLE"
      image_scanning_configuration = {
        scan_on_push = true
      }
      encryption_configuration = {
        encryption_type = "AES256"
        kms_key         = null
      }
    }
  }
}

variable "group_name" {
  type        = string
  description = "Repositories group name"
}

variable "codeowners" {
  type        = list(any)
  description = "Repositories codeowners"
}

variable "github_repositories" {
  type        = map(any)
  description = "Map of Github repository variables"

}

variable "github_org" {
  type        = string
  description = "Github Organization name"
}

variable "gh_team_admins_id" { type = string }
variable "gh_team_developers_id" { type = string }
variable "gh_team_admins_slug" { type = string }
