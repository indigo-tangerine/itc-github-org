data "aws_iam_policy_document" "default_ecr_policy" {
  statement {
    sid    = "AllowOrganizationToGet"
    effect = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:DescribeRepositories",
      "ecr:DescribeImages",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages"
    ]
    principals {
      type        = "AWS"
      identifiers = try(var.ecr_get_permissions_allowed_accounts, local.aws_account_id) # data.aws_organizations_organization.organization.accounts[*].id
    }
  }

  statement {
    sid    = "AllowCicdToManageAndPut"
    effect = "Allow"
    actions = [
      "ecr:*"
    ]
    principals {
      type        = "AWS"
      identifiers = try(var.ecr_put_permissions_allowed_accounts, local.aws_account_id) # ["288294394121", "522044537874"]
    }
  }
}
#tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "repositories" {
  for_each = var.ecr_repositories

  name                 = each.key
  image_tag_mutability = try(each.value.image_tag_mutability, "IMMUTABLE")

  image_scanning_configuration {
    scan_on_push = try(each.value.image_scanning_configuration.scan_on_push, true)
  }
  encryption_configuration {
    encryption_type = try(each.value.encryption_configuration.encryption_type, "AES256")
    kms_key         = try(each.value.encryption_configuration.kms_key, null)
  }
  tags = {
    GroupName = var.group_name
  }
}

resource "aws_ecr_repository_policy" "repository_policy" {
  for_each = aws_ecr_repository.repositories

  repository = each.value.name

  policy = data.aws_iam_policy_document.default_ecr_policy.json
}

resource "aws_ecr_lifecycle_policy" "default_ecr_lifecyclepolicy" {
  for_each = aws_ecr_repository.repositories

  repository = each.value.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire UNTAGGED images older than 1 day",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 1
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
