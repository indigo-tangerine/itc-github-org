resource "aws_resourcegroups_group" "core_cicd_resource_group" {
  name = var.group_name

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": ["AWS::AllSupported"],
  "TagFilters": [
    {
      "Key": "GroupName",
      "Values": ["${var.group_name}"]
    }
  ]
}
JSON
  }

}



