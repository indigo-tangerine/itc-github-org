# Usage

<!--- BEGIN_TF_DOCS --->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 4.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_github"></a> [github](#provider\_github) | ~> 4.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cdk_projects"></a> [cdk\_projects](#module\_cdk\_projects) | ./modules/gh_repo | n/a |
| <a name="module_tfm_modules"></a> [tfm\_modules](#module\_tfm\_modules) | ./modules/gh_repo | n/a |
| <a name="module_tfm_projects"></a> [tfm\_projects](#module\_tfm\_projects) | ./modules/gh_repo | n/a |

### Resources

| Name | Type |
|------|------|
| [github_team.admins](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team.developers](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team_membership.admins_maintainers](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership) | resource |
| [github_team_membership.admins_members](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership) | resource |
| [github_team_membership.developers_members](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [github_team.admins](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/team) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admins_team_maintainers"></a> [admins\_team\_maintainers](#input\_admins\_team\_maintainers) | n/a | `list(any)` | <pre>[<br>  "ruebroad"<br>]</pre> | no |
| <a name="input_admins_team_members"></a> [admins\_team\_members](#input\_admins\_team\_members) | Project Variables | `list(any)` | `[]` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS Account ID | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `"eu-west-1"` | no |
| <a name="input_aws_role_external_id"></a> [aws\_role\_external\_id](#input\_aws\_role\_external\_id) | TF\_VAR env var from github org secrets | `string` | n/a | yes |
| <a name="input_client"></a> [client](#input\_client) | n/a | `string` | n/a | yes |
| <a name="input_developers_team_maintainers"></a> [developers\_team\_maintainers](#input\_developers\_team\_maintainers) | n/a | `list(any)` | `[]` | no |
| <a name="input_developers_team_members"></a> [developers\_team\_members](#input\_developers\_team\_members) | n/a | `list(any)` | `[]` | no |
| <a name="input_github_actions_session_name"></a> [github\_actions\_session\_name](#input\_github\_actions\_session\_name) | n/a | `string` | `"GitHubActions"` | no |
| <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id) | n/a | `any` | n/a | yes |
| <a name="input_github_installation_id"></a> [github\_installation\_id](#input\_github\_installation\_id) | n/a | `any` | n/a | yes |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | n/a | `string` | n/a | yes |
| <a name="input_github_pem_file"></a> [github\_pem\_file](#input\_github\_pem\_file) | n/a | `any` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | n/a | yes |
| <a name="input_service_group"></a> [service\_group](#input\_service\_group) | n/a | `string` | `"main"` | no |
| <a name="input_service_version"></a> [service\_version](#input\_service\_version) | n/a | `string` | `"0.0.0"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | n/a | `string` | `"dev"` | no |
| <a name="input_tfm_state_ddb_table_name"></a> [tfm\_state\_ddb\_table\_name](#input\_tfm\_state\_ddb\_table\_name) | n/a | `string` | `"tfm-state-lock"` | no |

### Outputs

No outputs.

<!--- END_TF_DOCS --->
