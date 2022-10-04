targetScope = 'managementGroup'

@description('Prefix for the management group hierarchy. DEFAULT VALUE = alz')
@minLength(2)
@maxLength(10)
param parTopLevelManagementGroupPrefix string = 'alz'

@description('The region where the Log Analytics Workspace & Automation Account are deployed. DEFAULT VALUE = eastus')
param parLogAnalyticsWorkSpaceAndAutomationAccountLocation string = 'eastus'

@description('Log Analytics Workspace Resource ID. - DEFAULT VALUE: Empty String ')
param parLogAnalyticsWorkspaceResourceID string = ''

@description('Number of days of log retention for Log Analytics Workspace. - DEFAULT VALUE: 365')
param parLogAnalyticsWorkspaceLogRetentionInDays string = '365'

@description('Automation account name. - DEFAULT VALUE: alz-automation-account')
param parAutomationAccountName string = 'alz-automation-account'

@description('An e-mail address that you want Microsoft Defender for Cloud alerts to be sent to.')
param parMSDFCEmailSecurityContact string = 'security_contact@replace_me.com'

@description('ID of the DdosProtectionPlan which will be applied to the Virtual Networks.  Default: Empty String')
param parDdosProtectionPlanId string = ''

module deployment 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/alzdefaultpolicyassignments:v1.0' = {
  name: 'policydefinitionsdeployment'
  params: {
    parTopLevelManagementGroupPrefix: parTopLevelManagementGroupPrefix
    parLogAnalyticsWorkSpaceAndAutomationAccountLocation: parLogAnalyticsWorkSpaceAndAutomationAccountLocation
    parLogAnalyticsWorkspaceResourceID: parLogAnalyticsWorkspaceResourceID
    parLogAnalyticsWorkspaceLogRetentionInDays: parLogAnalyticsWorkspaceLogRetentionInDays
    parAutomationAccountName: parAutomationAccountName
    parMSDFCEmailSecurityContact: parMSDFCEmailSecurityContact
    parDdosProtectionPlanId: parDdosProtectionPlanId
  }
  scope: managementGroup()
}
