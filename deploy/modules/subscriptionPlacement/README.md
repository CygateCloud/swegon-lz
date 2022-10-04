# Module: Subscription placement v1.0

This module moves one or more subscriptions to be a child of the specified management group. Once the subscription(s) are moved under the management group, Azure Policies assigned to the management group or its parent management group(s) will begin to govern the subscription(s).

## Update image

```powershell
Publish-AzBicepModule `
-FilePath infra-as-code\bicep\modules\subscriptionPlacement\subscriptionPlacement.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/subscriptionplacement:v1.0
```

## Parameters

The module requires the following required input parameters.

 | Parameter                  | Type            | Description                                                                 | Requirement                                  | Example                                                                                                                                                                                        |
 | -------------------------- | --------------- | --------------------------------------------------------------------------- | -------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
 | parSubscriptionIds         | Array of string | Array of Subscription Ids that should be moved to the new management group. | Mandatory input                              | Empty: `[]` or <br />1 Subscription: `["4f9f8765-911a-4a6d-af60-4bc0473268c0"]` or<br />Many Subscriptions: `["34b63c8f-1782-42e6-8fb9-ba6ee8b99735", "4f9f8765-911a-4a6d-af60-4bc0473268c0"]` |
 | parTargetManagementGroupId | string          | Target management group for the subscription.                               | Mandatory input, management group must exist | `alz-platform-connectivity`                                                                                                                                                                    |

## Deployment

In this example, the subscriptions `66494c37-c071-4804-91c9-ef6b7b8b22ad` will be moved to `estosv-platform-management` management group. 

> For the  examples below we assume you have downloaded or cloned the Git repo as-is and are in the root of the repository as your selected directory in your terminal of choice.

### PowerShell

```powershell
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
```

# Module: Subscription placement v1.1
Append update information.