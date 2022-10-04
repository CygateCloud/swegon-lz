# Module: Policy Assignments alzDefaults v1.0

This module deploys the default Azure Landing Zone Azure Policy Assignments to the Management Group Hierarchy and also assigns the relevant RBAC for the system-assigned Managed Identities created for policies that require them (e.g DeployIfNotExist & Modify effect policies).

## Update image

```powershell
Publish-AzBicepModule `
-FilePath infra-as-code\bicep\modules\policy\assignments\alzDefaults\alzDefaultPolicyAssignments.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/alzdefaultpolicyassignments:v1.0
```

## Parameters

> Please use the scroll horizontal scroll bar at the bottom of this table to scroll along to see the other columns!

The module requires the following inputs:

 | Parameter                                            | Description                                                                        | Requirement | Example                                                                                                                                               | Default Value                     |
 | ---------------------------------------------------- | ---------------------------------------------------------------------------------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------- |
 | parTopLevelManagementGroupPrefix                     | Prefix for the management group hierarchy.                                         | Yes         | `alz`                                                                                                                                                 | `alz`                             |
 | parLogAnalyticsWorkSpaceAndAutomationAccountLocation | The region where the Log Analytics Workspace & Automation Account are deployed.    | Yes         | `eastus`                                                                                                                                              | `eastus`                          |
 | parLogAnalyticsWorkspaceResourceID                   | Log Analytics Workspace Resource ID                                                | Yes         | `/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/alz-logging/providers/Microsoft.OperationalInsights/workspaces/alz-log-analytics` | None                              |
 | parLogAnalyticsWorkspaceLogRetentionInDays           | Number of days of log retention for Log Analytics Workspace                        | Yes         | `365`                                                                                                                                                 | `365`                             |
 | parAutomationAccountName                             | Automation Account name                                                            | Yes         | `alz-automation-account`                                                                                                                              | `alz-automation-account`          |
 | parMSDFCEmailSecurityContact                         | An e-mail address that you want Microsoft Defender for Cloud alerts to be sent to. | Yes         | `security_contact@replace_me.com`                                                                                                                     | `security_contact@replace_me.com` |
 | parDdosProtectionPlanId                              | ID of the DDoS Protection Plan which will be applied to the Virtual Networks       | Yes         | `/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/Hub_Networking_POC/providers/Microsoft.Network/ddosProtectionPlans/alz-Ddos-Plan` | (empty string)                    |

## Deployment

> For the examples below we assume you have downloaded or cloned the Git repo as-is and are in the root of the repository as your selected directory in your terminal of choice.

### PowerShell

```powershell

$managementGroupId = 'estosv'
$location = 'westeurope'
$parTopLevelManagementGroupPrefix = 'estosv'
$parLogAnalyticsWorkSpaceAndAutomationAccountLocation = 'westeurope'
$parLogAnalyticsWorkspaceResourceID = '/subscriptions/66494c37-c071-4804-91c9-ef6b7b8b22ad/resourcegroups/tosv-mgmt/providers/microsoft.operationalinsights/workspaces/tosv-law'
$parLogAnalyticsWorkspaceLogRetentionInDays = '365'
$parAutomationAccountName = 'tosv-aauto'
$parMSDFCEmailSecurityContact = 'tommy.svensson@cygate.se'
$parDdosProtectionPlanId = ''

New-AzManagementGroupDeployment `
  -TemplateFile deploy\modules\policyAssignments\alzDefaults\alzDefaultPolicyAssignments.bicep `
  -ManagementGroupId $managementGroupId `
  -Location $location `
  -parTopLevelManagementGroupPrefix $parTopLevelManagementGroupPrefix `
  -parLogAnalyticsWorkSpaceAndAutomationAccountLocation $parLogAnalyticsWorkSpaceAndAutomationAccountLocation `
  -parLogAnalyticsWorkspaceResourceID $parLogAnalyticsWorkspaceResourceID `
  -parLogAnalyticsWorkspaceLogRetentionInDays $parLogAnalyticsWorkspaceLogRetentionInDays `
  -parAutomationAccountName $parAutomationAccountName `
  -parMSDFCEmailSecurityContact $parMSDFCEmailSecurityContact `
  -parDdosProtectionPlanId $parDdosProtectionPlanId  `
  -WhatIf
```

# Module: Policy Assignments alzDefaults v1.1
Append update information.