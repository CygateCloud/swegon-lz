targetScope = 'managementGroup'

@description('Provide a name for the alias. This name will also be the display name of the subscription.')
param subscriptionAliasName string

@description('Provide the full resource ID of billing scope to use for subscription creation.')
param billingScope string

@description('Provide the type of subscription')
@allowed([
  'Production'
  'DevTest'
])
param workload string

@description('Provide the ID of target Management Group to use for subscription placement.')
param targetManagementGroup string

// Create subscription and output the GUID
module spokeSubscription 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/spokesubscription:v1.0' = {
  name: 'create-${subscriptionAliasName}'
  params: {
    billingScope: billingScope
    subscriptionAliasName: subscriptionAliasName
    targetManagementGroup: targetManagementGroup
    workload: workload
  }
}
