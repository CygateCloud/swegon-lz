# Module: Spoke subscription v1.0

This module deploys a spoke subscription.

## Update image
```powershell
Publish-AzBicepModule `
-FilePath infra-as-code\bicep\modules\spokeSubscription\spokeSubscription.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/spokesubscription:v1.0
```

## Parameters

The module requires the following inputs:

 | Parameter                    | Type   | Default                    | Description                                                         | Requirement | Example                                                                                                                                               |
 | ---------------------------- | ------ | -------------------------- | ------------------------------------------------------------------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
 | subscriptionAliasName | string | None | Provide a name for the alias. This name will also be the display name of the subscription | None | `$subscriptionName` |
 | billingScope | string | None | Provide the full resource ID of billing scope to use for subscription creation | None | /providers/Microsoft.Billing/BillingAccounts/$billingaccount/enrollmentAccounts/$enrollmentAccount" |
 | workload | string | Production | Provide the type of subscription to be created | None | Production or DevTest |
 | targetManagementGroup | string | None | Provide the ID of target Management Group to use for subscription placement | None | 'preem-landingzone-corp'                                                                                                                                        |
 
## Deployment

In this example, the spoke subscirption will be deployed. 

> For the examples below we assume you have downloaded or cloned the Git repo as-is and are in the root of the repository as your selected directory in your terminal of choice.

### PowerShell

```powershell
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
```

# Module: Spoke subscription v1.1
Append update information.