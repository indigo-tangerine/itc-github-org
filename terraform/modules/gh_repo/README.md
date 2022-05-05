# GitHub Repository Configuration

## Creating from a template repository

## Usage

<!--- BEGIN_TF_DOCS --->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 4.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_github"></a> [github](#provider\_github) | ~> 4.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.default_ecr_lifecyclepolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.repositories](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.repository_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_resourcegroups_group.core_cicd_resource_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group) | resource |
| [aws_s3_bucket.artifacts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.artifacts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_public_access_block.artifacts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.artifacts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.artifacts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [github_branch_default.main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_branch_protection.development_branch](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_branch_protection.main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_branch_protection.release_branches](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_repository.main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_environment.main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment) | resource |
| [github_repository_file.codeowners_file](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_team.codeowners](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team_membership.codeowners](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership) | resource |
| [github_team_repository.admins_team](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [github_team_repository.codeowners](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [github_team_repository.developers](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.default_ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [github_team.approvers](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/team) | data source |
| [github_user.approvers](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/user) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_codeowners"></a> [codeowners](#input\_codeowners) | Repositories codeowners | `list(any)` | n/a | yes |
| <a name="input_ecr_get_permissions_allowed_accounts"></a> [ecr\_get\_permissions\_allowed\_accounts](#input\_ecr\_get\_permissions\_allowed\_accounts) | List of AWS accounts allowed to pull from ECR repository | `list(any)` | `[]` | no |
| <a name="input_ecr_put_permissions_allowed_accounts"></a> [ecr\_put\_permissions\_allowed\_accounts](#input\_ecr\_put\_permissions\_allowed\_accounts) | List of AWS accounts allowed to push to ECR repository | `list(any)` | `[]` | no |
| <a name="input_ecr_repositories"></a> [ecr\_repositories](#input\_ecr\_repositories) | Map of ECR repository variables | `map(any)` | <pre>{<br>  "ecr-name": {<br>    "encryption_configuration": {<br>      "encryption_type": "AES256",<br>      "kms_key": null<br>    },<br>    "image_scanning_configuration": {<br>      "scan_on_push": true<br>    },<br>    "image_tag_mutability": "IMMUTABLE"<br>  }<br>}</pre> | no |
| <a name="input_gh_team_admins_id"></a> [gh\_team\_admins\_id](#input\_gh\_team\_admins\_id) | n/a | `string` | n/a | yes |
| <a name="input_gh_team_admins_node_id"></a> [gh\_team\_admins\_node\_id](#input\_gh\_team\_admins\_node\_id) | n/a | `string` | n/a | yes |
| <a name="input_gh_team_admins_slug"></a> [gh\_team\_admins\_slug](#input\_gh\_team\_admins\_slug) | n/a | `string` | n/a | yes |
| <a name="input_gh_team_developers_id"></a> [gh\_team\_developers\_id](#input\_gh\_team\_developers\_id) | n/a | `string` | n/a | yes |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | Github Organization name | `string` | n/a | yes |
| <a name="input_github_repositories"></a> [github\_repositories](#input\_github\_repositories) | Map of Github repository variables | `any` | n/a | yes |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | Repositories group name | `string` | n/a | yes |

### Outputs

No outputs.

<!--- END_TF_DOCS --->
