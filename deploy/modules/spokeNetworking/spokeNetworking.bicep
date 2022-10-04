targetScope = 'resourceGroup'

param deploymentResourcegroup string = resourceGroup().name

@description('The Azure Region to deploy the resources into. Default: resourceGroup().location')
param parRegion string = resourceGroup().location

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

module deployment 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/spokenetworking:v1.0' = {
  name: 'hubnetworkingdeployment'
  params: {
    parRegion: parRegion
    parBGPRoutePropagation: parBGPRoutePropagation
    parTags: parTags
    parSpokeNetworkAddressPrefix: parSpokeNetworkAddressPrefix
    parSpokeSubnetNetworkAddressPrefix: parSpokeSubnetNetworkAddressPrefix
    parSpokeNetworkName: parSpokeNetworkName
    parSpokeVirtualNetworkPeerName: parSpokeVirtualNetworkPeerName
    parDNSServerIPArray: parDNSServerIPArray
    parNextHopIPAddress: parNextHopIPAddress
    parSpoketoHubRouteTableName: parSpoketoHubRouteTableName
    parSpokeNsgName: parSpokeNsgName
    parHubVnetName: parHubVnetName
    parHubSubscriptionId: parHubSubscriptionId
    parHubResourceGroup: parHubResourceGroup
    createResourceLock: createResourceLock
  }
  scope: resourceGroup(deploymentResourcegroup)
}
