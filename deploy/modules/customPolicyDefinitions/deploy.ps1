
$location = 'westeurope'
$managementGroupId = 'estosv'

New-AzManagementGroupDeployment `
  -TemplateFile deploy\modules\customPolicyDefinitions\custom-policy-definitions.bicep `
  -Location $location `
  -ManagementGroupId $managementGroupId `
  -WhatIf
