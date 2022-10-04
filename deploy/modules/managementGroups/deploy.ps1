
$location = 'westeurope'

New-AzTenantDeployment `
  -TemplateFile deploy\modules\managementGroups\managementGroups.bicep.bicep `
  -Location $location `
  -WhatIf
