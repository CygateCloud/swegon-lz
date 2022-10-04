# Module: Custom Policy Definitions v1.0
This module deploys the custom Azure Policy Definitions & Initiatives supplied by the Azure Landing Zones conceptual architecture and reference implementation defined [here](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/architecture) to the specified Management Group.

## Update module image

```powershell
Publish-AzBicepModule `
-FilePath infra-as-code/bicep/modules/policy/definitions/custom-policy-definitions.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/custompolicydefinitions:v1.0
```

## Parameters

The module requires the following inputs:

 | Parameter                  | Description                                                                                                                                                             | Requirement                       | Example |
 | -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------- | ------- |
 | parTargetManagementGroupID | The management group scope to which the the policy definitions will be stored/deployed to. This management group must already exist before deploying this bicep module. | Mandatory input                   | `alz`   |
 
 ## Deployment
In this example, the custom policy definitions and policy set definitions will be deployed to the `estosv` management group (the intermediate root management group).

The input parameter file `custom-policy-definitions.parameters.example.json` defines the target management group to which the custom policy definitions will be deployed to. In this case, it will be the same management group (i.e. `alz`) as the one specified for the deployment operation. There is no change in the input parameter file for different Azure clouds because there is no change to the intermediate root management group.

> For the examples below we assume you have downloaded or cloned the Git repo as-is and are in the root of the repository as your selected directory in your terminal of choice.
> If the deployment provisioning state has failed due to policy definitions could not be found, this is often due to a known replication delay. Please re-run the deployment step below, and the deployment should succeed.

### PowerShell

```powershell
$location = 'westeurope'
$managementGroupId = 'estosv'

New-AzManagementGroupDeployment `
  -TemplateFile deploy\modules\customPolicyDefinitions\custom-policy-definitions.bicep `
  -Location $location `
  -ManagementGroupId $managementGroupId `
  -WhatIf
```

# Module: Custom Policy Definitions v1.1
Append update information.