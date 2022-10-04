$managementGroupId = 'estosv'
$location = 'westeurope'
$parSubscriptionIds = '66494c37-c071-4804-91c9-ef6b7b8b22ad'
$parTargetManagementGroupId = 'estosv-platform-management'

New-AzManagementGroupDeployment `
  -TemplateFile deploy\modules\subscriptionPlacement\subscriptionPlacement.bicep `
  -ManagementGroupId $managementGroupId `
  -Location $location `
  -parSubscriptionIds $parSubscriptionIds `
  -parTargetManagementGroupId $parTargetManagementGroupId `
  -WhatIf