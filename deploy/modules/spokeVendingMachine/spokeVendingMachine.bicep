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

@description('Provide location for spoke resource group.')
param parRegion string

@description('Provide a name for the spoke resource group.')
param parSpokeResourceGroupName string

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

// creating resources in the subscription requires an extra level of "nesting" to reference the subscriptionId as a module output and use for a scope
// The module outputs cannot be used for the scope property so needs to be passed down as a parameter one level
module resourceWrapper 'spokeResourceWrapper.bicep' = {
  name: 'nested-CreateResourceGroup-${parSpokeResourceGroupName}'
  dependsOn: [
    spokeSubscription
  ]
  params: {
    parRegion: parRegion
    parSpokeResourceGroupName: parSpokeResourceGroupName
    subscriptionId: spokeSubscription.outputs.subscriptionId // this cannot be referenced directly on the scope property of a module so needs to be wrapped in another module
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

output subscriptionId string = spokeSubscription.outputs.subscriptionId
output spokeVnetId string = resourceWrapper.outputs.spokeVnetId
