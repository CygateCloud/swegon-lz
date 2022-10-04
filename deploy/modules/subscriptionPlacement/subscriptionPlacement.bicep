targetScope = 'managementGroup'

@description('Array of Subscription Ids that should be moved to the new management group.')
param parSubscriptionIds array = []

@description('Target management group for the subscription.  This management group must exist.')
param parTargetManagementGroupId string

module deployment 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/subscriptionplacement:v1.0' = {
  name: 'policydefinitionsdeployment'
  params: {
    parSubscriptionIds: parSubscriptionIds
    parTargetManagementGroupId: parTargetManagementGroupId
  }
  scope: managementGroup()
}
