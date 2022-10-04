# Cygate documentation of ALZ implementation
This is the Cygate version of the Microsoft repo [ALZ-Bicep](https://github.com/Azure/ALZ-Bicep)

## Versioning of implementation branches

* Main: Is current production branch where modules stored in ACR are made from. It's not allowed to push directly to Main but to do so via branches.
* To update modules use code snippet below (!IMPORTANT: Make sure to update version tag before push since we can overwrite). Make sure to do "az login" to handle modules in ACR and to append change information in module README.

```powershell
Publish-AzBicepModule `
-FilePath infra-as-code\bicep\modules\modulename\modulename.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/modulename:v1.1
```
[CCD Azure Container Registry](https://portal.azure.com/#@cygateclouddivision.onmicrosoft.com/resource/subscriptions/a376ad86-9065-4dbd-9197-41861aa849e8/resourceGroups/rg-ccdregistry/providers/Microsoft.ContainerRegistry/registries/ccdregistryprod/overview)

## Pre reqs
1. Azure Active Directory Tenant.
2. Minimum 1 subscription. Subscription(s) are required when configuring Log Analytics Workspace & Hub Networking services. Each can be deployed in the same subscription or separate subscriptions based on deployment requirements.
3. Deployment Identity with Owner permission to the / root management group. Owner permission is required to allow the Service Principal Account to create role-based access control assignments.

[Prerequisites](https://github.com/Azure/ALZ-Bicep/wiki/DeploymentFlow#prerequisites)

## Deployment Flow
![Deployment Flow](/deploy/pics/high-level-deployment-flow.png)

1. [Management Group Module](/deploy/modules/managementGroups)
2. [Custom Policy Definitions Module](/deploy/modules/customPolicyDefinitions)
3. [Custom RBAC Role Definitions Module](/deploy/modules/customRoleDefinitions)
4. [Logging & Security Module](/deploy/modules/logging)
5. [Hub Networking Module](/deploy/modules/hubNetworking)
6. [RBAC Role Assignments Module](/deploy/modules/roleAssignments)
7. [Subscription Placement Module](/deploy/modules/subscriptionPlacement)
8. [Policy Assignments Module alzDefault](/deploy/modules/policyAssignments/alzDefaults)
9. [Spoke Network Module](/deploy/modules/spokeNetworking)
10. [Spoke Subscription Module](/deploy/modules/spokeSubscription)
