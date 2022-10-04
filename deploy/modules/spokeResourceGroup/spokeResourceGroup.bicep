targetScope = 'subscription'

@description('Provide location for spoke resource group.')
param parRegion string

@description('Provide a name for the spoke resource group.')
param parSpokeResourceGroupName string

module deployment 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/spokeresourcegroup:v1.0' = {
  name: 'create-${parSpokeResourceGroupName}'
  params: {
    parRegion: parRegion
    parSpokeResourceGroupName: parSpokeResourceGroupName
  }
  scope: subscription()
}
