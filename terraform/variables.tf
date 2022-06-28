# Default Variables

variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "aws_account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "aws_role_external_id" {
  type        = string
  description = "TF_VAR env var from github org secrets"
  sensitive   = true
}

variable "github_app_id" {}
variable "github_installation_id" {}
variable "github_pem_file" {}

variable "stage" {
  type    = string
  default = "dev"
}

variable "service_version" {
  type    = string
  default = "0.0.0"
}

variable "service_group" {
  type    = string
  default = "main"
}

variable "service" {
  type = string
}

variable "client" {
  type = string
}

variable "github_org" {
  type = string
}

variable "github_actions_session_name" {
  type    = string
  default = "GitHubActions"
}

variable "tfm_state_ddb_table_name" {
  type    = string
  default = "tfm-state-lock"
}

# Project Variables
variable "admins_team_members" {
  type    = list(any)
  default = []
}

variable "admins_team_maintainers" {
  type    = list(any)
  default = ["ruebroad"]
}

variable "developers_team_members" {
  type    = list(any)
  default = []
}

variable "developers_team_maintainers" {
  type    = list(any)
  default = []
}
