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

resource subscriptionAlias 'Microsoft.Subscription/aliases@2021-10-01' = {
  scope: tenant()
  name: subscriptionAliasName
  properties: {
    workload: workload
    displayName: subscriptionAliasName
    billingScope: billingScope
    additionalProperties: {
      managementGroupId: targetManagementGroup
      tags: {
        costcenter: '123'
      }
    }
  }
}

output subscriptionId string = subscriptionAlias.properties.subscriptionId
