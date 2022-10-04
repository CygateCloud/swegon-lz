targetScope = 'subscription'

@description('Provide location for spoke resource group.')
param parRegion string

@description('Provide a name for the spoke resource group.')
param parSpokeResourceGroupName string

resource resResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: parSpokeResourceGroupName
  location: parRegion
}

output outSpokeNetworkingResourceGroup string = resResourceGroup.name
output outSpokeNetworkingResourceGroupId string = resResourceGroup.id
