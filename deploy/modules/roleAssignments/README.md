# Module:  Role Assignments for Management Groups & Subscriptions

This module provides role assignment capabilities across Management Groups.
The role assignments can be performed for:
* Managed Identities (System and User Assigned)
* Service Principals
* Security Groups

This module contains 4 Bicep templates, you may optionally choose one of these modules to deploy depending on which scope you want to assign roles from broad to narrow; management group to subscription:

| Template                                | Description                                                                                                                               | Deployment Scope |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| roleAssignmentManagementGroup     | Performs role assignment on one management group                                                                                          | Management Group |
| roleAssignmentManagementGroupMany | Performs role assignment on one or more management groups.  This template uses `roleAssignmentManagementGroup` for the deployments. | Management Group |
| roleAssignmentSubscription        | Performs role assignment on one subscription                                                                                              | Subscription     |
| roleAssignmentSubscriptionMany    | Performs role assignment on one or more subscriptions.  This template uses `roleAssignmentSubscription` for the deployments.        | Management Group |

## Parameters

The module requires the following required input parameters.

All templates require an input for `parAssigneeObjectId` and this value is dependent on the Service Principal type.  Azure CLI and PowerShell commands can be executed to identify the correct `object id`.  Examples:

## Module: Role Assignments Management Group v1.0

### Update module image

```powershell
Publish-AzBicepModule `
-FilePath infra-as-code\bicep\modules\roleAssignments\roleAssignmentManagementGroup.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/roleassigmentmanagementgroup:v1.0
```

### Parameters Role Assignments Management Group
| Parameter                 | Type   | Description                                                                                                                                                               | Requirement                      | Example                                |
| ------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------- | -------------------------------------- |
| parRoleAssignmentNameGuid | string | A GUID representing the role assignment name.  Default:  guid(managmentGroup().name, parRoleDefinitionId, parAssigneeObjectId)                                                                   | Unique GUID                      | `f3b171da-2023-4508-b467-042a53f4cd5d` |
| parRoleDefinitionId       | string | Role Definition ID(i.e. GUID, Reader Role Definition ID:  acdd72a7-3385-48ef-bd42-f606fba81ae7)                                                                           | Must exist                       | `acdd72a7-3385-48ef-bd42-f606fba81ae7` |
| parAssigneePrincipalType  | string | Principal type of the assignee. Allowed values are `Group` (Security Group) or `ServicePrincipal` (Service Principal or System/User Assigned Managed Identity)            | One of [Group, ServicePrincipal] | `ServicePrincipal`                     |
| parAssigneeObjectId       | string | Object ID of groups, service principals or  managed identities. For managed identities use the principal ID. For service principals, use the object id and not the app ID | Must exist                       | `a86fe549-7f87-4873-8b0e-82f0081a0034` |

## Module: Role Assignments Management Group v1.1
Append update information.

## Module: Role Assignments Management Group Many v1.0

### Update image
```
Publish-AzBicepModule `
-FilePath infra-as-code\bicep\modules\roleAssignments\roleAssignmentManagementGroupMany.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/roleassignmentmanagementgroupmany:v1.0
```

### Parameters Role Assignments Management Group Many
| Parameter                | Type            | Description                                                                                                                                                              | Requirement                      | Example                                                  |
| ------------------------ | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------- | -------------------------------------------------------- |
| parManagementGroupIds    | Array of string | A list of management group scopes that will be used for role assignment (i.e. [alz-platform-connectivity, alz-platform-identity]).  Default = []                         | Must exist                       | `['alz-platform-connectivity', 'alz-platform-identity']` |
| parRoleDefinitionId      | string          | Role Definition ID(i.e. GUID, Reader Role Definition ID:  acdd72a7-3385-48ef-bd42-f606fba81ae7)                                                                          | Must exist                       | `acdd72a7-3385-48ef-bd42-f606fba81ae7`                   |
| parAssigneePrincipalType | string          | Principal type of the assignee. Allowed values are `Group` (Security Group) or `ServicePrincipal` (Service Principal or System/User Assigned Managed Identity)           | One of [Group, ServicePrincipal] | `ServicePrincipal`                                       |
| parAssigneeObjectId      | string          | Object ID of groups, service principals or managed identities. For managed identities use the principal ID. For service principals, use the object ID and not the app ID | Must exist                       | `a86fe549-7f87-4873-8b0e-82f0081a0034`                   |

## Module: Role Assignments Management Group Many v1.1
Append update information.

## Module: Role Assignments Subscription v1.0

### Update image
```
Publish-AzBicepModule `
-FilePath infra-as-code\bicep\modules\roleAssignments\roleAssignmentSubscription.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/roleassignmentsubscription:v1.0
```

### Parameters Role Assignments Subscription
| Parameter                 | Type   | Description                                                                                                                                                              | Requirement                      | Example                                |
| ------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------- | -------------------------------------- |
| parRoleAssignmentNameGuid | string | A GUID representing the role assignment name.  Default:  guid(subscription().subscriptionId, parRoleDefinitionId, parAssigneeObjectId)                                   | Unique GUID                      | `f3b171da-2023-4508-b467-042a53f4cd5d` |
| parRoleDefinitionId       | string | Role Definition Id (i.e. GUID, Reader Role Definition ID:  acdd72a7-3385-48ef-bd42-f606fba81ae7)                                                                         | Must exist                       | `acdd72a7-3385-48ef-bd42-f606fba81ae7` |
| parAssigneePrincipalType  | string | Principal type of the assignee. Allowed values are `Group` (Security Group) or `ServicePrincipal` (Service Principal or System/User Assigned Managed Identity)           | One of [Group, ServicePrincipal] | `ServicePrincipal`                     |
| parAssigneeObjectId       | string | Object ID of groups, service principals or managed identities. For managed identities use the principal ID. For service principals, use the object ID and not the app ID | Must exist                       | `a86fe549-7f87-4873-8b0e-82f0081a0034` |

## Module: Role Assignments Subscription v1.1
Append update information.

## Module: Role Assignments Subscription Many v1.0

### Update image
```
Publish-AzBicepModule `
-FilePath infra-as-code\bicep\modules\roleAssignments\roleAssignmentSubscriptionMany.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/roleassignmentsubscriptionmany:v1.0
```

### Parameters Role Assignments Subscription Many
| Parameter                | Type            | Description                                                                                                                                                              | Requirement                      | Example                                                                           |
| ------------------------ | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------- | --------------------------------------------------------------------------------- |
| parSubscriptionIds       | Array of string | A list of subscription ids that will be used for role assignment (i.e. 4f9f8765-911a-4a6d-af60-4bc0473268c0)  Default = []                                               | Must exist                       | `['4f9f8765-911a-4a6d-af60-4bc0473268c0','82f7705e-3386-427b-95b7-cbed91ab29a7']` |
| parRoleDefinitionId      | string          | Role Definition ID(i.e. GUID, Reader Role Definition ID:  acdd72a7-3385-48ef-bd42-f606fba81ae7)                                                                          | Must exist                       | `acdd72a7-3385-48ef-bd42-f606fba81ae7`                                            |
| parAssigneePrincipalType | string          | Principal type of the assignee. Allowed values are `Group` (Security Group) or `ServicePrincipal` (Service Principal or System/User Assigned Managed Identity)           | One of [Group, ServicePrincipal] | `ServicePrincipal`                                                                |
| parAssigneeObjectId      | string          | Object ID of groups, service principals or managed identities. For managed identities use the principal ID. For service principals, use the object ID and not the app ID | Must exist                       | `a86fe549-7f87-4873-8b0e-82f0081a0034`                                            |

## Module: Role Assignments Subscription Many v1.1
Append update information.

## Deployment

> For the examples below we assume you have downloaded or cloned the Git repo as-is and are in the root of the repository as your selected directory in your terminal of choice.

### PowerShell

```powershell
$managementGroupId = 'estosv'
$location = 'eastus'
$parRoleAssignmentNameGuid = ''
$parRoleDefinitionId = ''
$parAssigneePrincipalType = ''
$parAssigneeObjectId = ''

New-AzManagementGroupDeployment `
  -TemplateFile deploy\modules\roleAssignments\roleAssignmentManagementGroup.bicep `
  -ManagementGroupId $managementGroupId `
  -Location $location `
  -parRoleAssignmentNameGuid $parRoleAssignmentNameGuid `
  -parRoleDefinitionId $parRoleDefinitionId `
  -parAssigneePrincipalType $parAssigneePrincipalType `
  -parAssigneeObjectId $parAssigneeObjectId
```