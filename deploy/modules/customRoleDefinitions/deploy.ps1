
$location = 'westeurope'
$managementGroupId = 'estosv'

New-AzManagementGroupDeployment `
  -TemplateFile deploy\modules\customRoleDefinitions\customRoleDefinitions.bicep `
  -Location $location `
  -ManagementGroupId $managementGroupId `
  -WhatIf
