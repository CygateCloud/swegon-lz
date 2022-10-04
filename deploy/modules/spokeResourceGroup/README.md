# Module: Spoke Resource Group v1.0

This module deploys a resource group into a subscription.

## Update image
```powershell
Publish-AzBicepModule `
-FilePath infra-as-code\bicep\modules\spokeResourceGroup\spokeResourceGroup.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/spokeresourcegroup:v1.0 
```

## Parameters

The module requires the following inputs:

 | Parameter                    | Type   | Default                    | Description                                                         | Requirement | Example                                                                                                                                               |
 | ---------------------------- | ------ | -------------------------- | ------------------------------------------------------------------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
 | parRegion | string | None | Provide location for spoke resource group | None | `westeurope` |
 | parSpokeResourceGroupName | string | None | Provide a name for the spoke resource group | None | rg-network |
 
## Deployment

In this example, the resource group will be deployed. 

> For the examples below we assume you have downloaded or cloned the Git repo as-is and are in the root of the repository as your selected directory in your terminal of choice.

### PowerShell

```powershell
$subscriptionId = ''
$parRegion = 'westeurope'
$parSpokeResourceGroupName = ''

set-azcontext -subscription $subscriptionId
New-Azdeployment `
-Name $parSpokeResourceGroupName
-parRegion $parRegion 
-WhatIf
```

# Module: Spoke Resource Group v1.1
Append update information.