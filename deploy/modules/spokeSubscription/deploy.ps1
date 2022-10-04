
param (
    $AppName,
    $environment,
    $enrollmentAccount,
    $targetManagementGroup
)
$subscriptionName = "sub-" + $AppName + "-" + $environment
$billingaccount = "xxxxxxx"
$workloadType = "Production"
$targetManagementGroupId = "/providers/Microsoft.Management/managementGroups/" + $targetManagementGroup

New-AzManagementGroupDeployment `
-Name subscriptionName
-TemplateFile deploy\modules\spokeSubscription\spokeSubscription.bicep `
-subscriptionAliasName $subscriptionName `
-billingScope "/providers/Microsoft.Billing/BillingAccounts/$billingaccount/enrollmentAccounts/$enrollmentAccount" `
-workload $workloadType `
-targetManagementGroup $targetManagementGroupId `
-WhatIf