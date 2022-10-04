targetScope = 'managementGroup'

@description('Provide location for spoke resource group.')
param parRegion string

@description('Provide a name for the spoke resource group.')
param parSpokeResourceGroupName string

@description('Subscription ID for the deployment.')
param subscriptionId string

@description('Switch which allows BGP Route Propagation to be disabled on the route table')
param parBGPRoutePropagation bool = false

@description('Tags you would like to be applied to all resources in this module')
param parTags object = {}

@description('The IP address range for all virtual networks to use.')
param parSpokeNetworkAddressPrefix string = '10.11.0.0/16'

@description('The IP address range for default subnet to use.')
param parSpokeSubnetNetworkAddressPrefix string = '10.11.0.0/25'

@description('The Name of the Spoke Virtual Network. Default: vnet-spoke')
param parSpokeNetworkName string = 'vnet-spoke'

@description('The Name of the Spoke Virtual Network. Default: vnet-spoke')
param parSpokeVirtualNetworkPeerName string = 'spoke-to-hub-peering'

@description('Array of DNS Server IP addresses for VNet. Default: Empty Array')
param parDNSServerIPArray array = []

@description('IP Address where network traffic should route to leveraged with DNS Proxy. Default: Empty String')
param parNextHopIPAddress string = ''

@description('Name of Route table to create for the default route of Hub. Default: rt-spoke')
param parSpoketoHubRouteTableName string = 'rt-spoke'

@description('Name of Network Security Group to create for the default route of Hub. Default: nsg-spoke')
param parSpokeNsgName string = 'nsg-spoke'

@description('The Subscription ID of the Hub')
param parHubSubscriptionId string = ''

@description('The Name of the Hub Virtual Network.')
param parHubVnetName string = ''

@description('The Name of the Resource Group of the Hub')
param parHubResourceGroup string = ''

@description('Switch that allows for the deployment of resource locks on networking resource group')
param createResourceLock bool = false

// deploy to the subscription and create the resourceGroup
module spokeResourceGroup 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/spokeresourcegroup:v1.0' = {
  scope: subscription(subscriptionId)
  name: 'create-${parSpokeResourceGroupName}'
  params: {
    parRegion: parRegion
    parSpokeResourceGroupName: parSpokeResourceGroupName
  }
}

// deploy to the resource group
module spokeNetworking 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/spokenetworking:v1.0' = {
  scope: resourceGroup(subscriptionId,'rg-network')
  name: 'create-${parSpokeNetworkName}'
  dependsOn: [
    spokeResourceGroup
  ]
  params: {
    parRegion: parRegion
    parBGPRoutePropagation: parBGPRoutePropagation
    parTags: parTags
    parSpokeNetworkAddressPrefix: parSpokeNetworkAddressPrefix
    parSpokeSubnetNetworkAddressPrefix: parSpokeSubnetNetworkAddressPrefix
    parSpokeVirtualNetworkPeerName: parSpokeVirtualNetworkPeerName
    parDNSServerIPArray: parDNSServerIPArray
    parNextHopIPAddress: parNextHopIPAddress
    parSpokeNetworkName: parSpokeNetworkName
    parSpoketoHubRouteTableName: parSpoketoHubRouteTableName
    parSpokeNsgName: parSpokeNsgName
    parHubSubscriptionId: parHubSubscriptionId
    parHubVnetName: parHubVnetName
    parHubResourceGroup: parHubResourceGroup
    createResourceLock: createResourceLock
  }
}

output spokeVnetId string = spokeNetworking.outputs.outSpokeVirtualNetworkid
