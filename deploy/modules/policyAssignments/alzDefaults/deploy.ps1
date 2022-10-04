
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
