targetScope = 'resourceGroup'

param parLogAnalyticsWorkspaceName string = 'estosv-log-analytics'
param parLogAnalyticsWorkspaceRegion string = resourceGroup().location
param parLogAnalyticsWorkspaceLogRetentionInDays int = 365
param parAutomationAccountName string = 'estosv-automation-account'
param parAutomationAccountRegion string = resourceGroup().location
param deploymentResourcegroup string = resourceGroup().name

module deployment 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/logging:v1.0' = {
  name: 'loggingdeployment'
  params: {
    parLogAnalyticsWorkspaceName: parLogAnalyticsWorkspaceName
    parLogAnalyticsWorkspaceRegion: parLogAnalyticsWorkspaceRegion
    parLogAnalyticsWorkspaceLogRetentionInDays: parLogAnalyticsWorkspaceLogRetentionInDays
    parAutomationAccountName: parAutomationAccountName
    parAutomationAccountRegion: parAutomationAccountRegion
  }
  scope: resourceGroup(deploymentResourcegroup)
}
