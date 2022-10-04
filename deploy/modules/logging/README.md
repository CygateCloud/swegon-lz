
# Module: Logging & Sentinel v1.0
Deploys Azure Log Analytics Workspace, Automation Account (linked together) & multiple Solutions deploy to the Log Analytics Workspace to an existing Resource Group.

Automation Account will be linked to Log Analytics Workspace to provide integration for Update Management, Change Tracking and Inventory, and Start/Stop VMs during off-hours for your servers and virtual machines. Only one mapping can exist between Log Analytics Workspace and Automation Account.

The module will deploy the following Log Analytics Workspace solutions by default. Solutions can be customized as required:
* AgentHealthAssessment
* AntiMalware
* AzureActivity
* ChangeTracking
* Security
* SecurityInsights (Azure Sentinel)
* ServiceMap
* SQLAssessment
* Updates
* VMInsights

 > Only certain regions are supported to link Log Analytics Workspace & Automation Account together (linked workspaces). Reference:  [Supported regions for linked Log Analytics workspace](https://docs.microsoft.com/azure/automation/how-to/region-mappings)

## Update module image

```powershell
Connect-AzContainerRegistry -Name ccdregistryprod
Publish-AzBicepModule `
-FilePath infra-as-code/bicep/modules/logging/logging.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/logging:v1.0
```

## Parameters

The module requires the following required input parameters.

| Parameter                                  | Type            | Description                                                 | Requirement                                                                                                                                                                                               | Example                                                                                                      |
| ------------------------------------------ | --------------- | ----------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| parLogAnalyticsWorkspaceName               | string          | Log Analytics Workspace name                                | Mandatory input, default: `alz-log-analytics`                                                                                                                                                             | `alz-log-analytics`                                                                                          |
| parLogAnalyticsWorkspaceRegion             | string          | Region name                                                 | Mandatory input, default: `resourceGroup().location`                                                                                                                                                      | `eastus`                                                                                                     |
| parLogAnalyticsWorkspaceLogRetentionInDays | int             | Number of days of log retention for Log Analytics Workspace | Mandatory input between 30-730, default: `365`                                                                                                                                                            | `365`                                                                                                        |
| parLogAnalyticsWorkspaceSolutions          | Array of string | Solutions that will be added to the Log Analytics Workspace | 1 or more of `AgentHealthAssessment`, `AntiMalware`, `AzureActivity`, `ChangeTracking`, `Security`, `SecurityInsights`, `ServiceMap`, `SQLAssessment`, `Updates`, `VMInsights`, default:  *all solutions* | Empty: `[]`<br />1 Solution: `["SecurityInsights"]`<br />Many Solutions: `["SecurityInsights","VMInsights"]` |
| parAutomationAccountName                   | string          | Automation account name                                     | Mandatory input, name must be unique in the subscription, default: `alz-automation-account`                                                                                                               | `alz-automation-account`                                                                                     |
| parAutomationAccountRegion                 | string          | Region name                                                 | Mandatory input, default: `resourceGroup().location`                                                                                                                                                      | `eastus`                                                                                                     |
| parTags                      | object | Empty object `{}`          | Array of Tags to be applied to all resources in the logging module   | `{"key": "value"}`                                                                                                                                    |

## Deployment

In this example, a Log Analytics Workspace and Automation Account will be deployed to the resource group `alz-logging`.  The inputs for this module are defined in `logging.parameters.example.json`.

There are separate input parameters files depending on which Azure cloud you are deploying because this module deploys resources into an existing resource group under the specified region. There is no change to the Bicep template file.
| Azure Cloud    | Bicep template | Input parameters file              |
| -------------- | -------------- | ---------------------------------- |
| Global regions | logging.bicep  | logging.parameters.example.json    |
| China regions  | logging.bicep  | mc-logging.parameters.example.json |

> For the examples below we assume you have downloaded or cloned the Git repo as-is and are in the root of the repository as your selected directory in your terminal of choice.
> If the deployment failed due an error that your alz-log-analytics/Automation resource of type 'Microsoft.OperationalInsights/workspaces/linkedServices' was not found, please retry the deployment step and it would succeed.

### PowerShell

```powershell
$resourcegroup = ''
$subscriptionId = ''
Set-AzContext -Subscription $subscriptionId # Set management subscription

New-AzResourceGroupDeployment `
  -TemplateFile deploy\modules\logging\logging.bicep `
  -ResourceGroup $resourcegroup `
  -WhatIf
```

# Module: Logging & Sentinel v1.1
Append update information.