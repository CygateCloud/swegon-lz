
Set-AzContext -Subscription 'subscriptionId' #Set network subscription
$resourcegroup = ''
$companyprefix = ''

New-AzResourceGroupDeployment `
  -TemplateFile deploy\modules\hubNetworking\hubNetworking.bicep `
  -ResourceGroup $resourcegroup `
  -parDDoSEnabled $false `
  -parCompanyPrefix $companyprefix `
  -WhatIf
