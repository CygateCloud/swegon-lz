
$resourcegroup = ''
$subscriptionId = ''
Set-AzContext -Subscription $subscriptionId # Set management subscription

New-AzResourceGroupDeployment `
  -TemplateFile deploy\modules\logging\logging.bicep `
  -ResourceGroup $resourcegroup `
  -WhatIf
