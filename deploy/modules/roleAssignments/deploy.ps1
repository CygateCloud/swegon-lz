
$managementGroupId = 'estosv'
$location = 'eastus'
$parRoleAssignmentNameGuid = ''
$parRoleDefinitionId = ''
$parAssigneePrincipalType = ''
$parAssigneeObjectId = ''

New-AzManagementGroupDeployment `
  -TemplateFile deploy\modules\roleAssignments\roleAssignmentManagementGroup.bicep `
  -ManagementGroupId $managementGroupId `
  -Location $location `
  -parRoleAssignmentNameGuid $parRoleAssignmentNameGuid `
  -parRoleDefinitionId $parRoleDefinitionId `
  -parAssigneePrincipalType $parAssigneePrincipalType `
  -parAssigneeObjectId $parAssigneeObjectId