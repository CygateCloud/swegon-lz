targetScope = 'resourceGroup'
param deploymentResourcegroup string = resourceGroup().name

@description('The Azure Region to deploy the resources into. Default: resourceGroup().location')
param parRegion string = resourceGroup().location

@description('Switch which allows Bastion deployment to be disabled. Default: true')
param parBastionEnabled bool = true

@description('Switch which allows DDOS deployment to be disabled. Default: true')
param parDDoSEnabled bool = false

@description('DDOS Plan Name. Default: {parCompanyPrefix}-DDos-Plan')
param parDDoSPlanName string = '${parCompanyPrefix}-DDoS-Plan'

@description('Switch which allows Azure Firewall deployment to be disabled. Default: true')
param parAzureFirewallEnabled bool = true

@description('Switch which enables DNS Proxy to be enabled on the Azure Firewall. Default: true')
param parNetworkDNSEnableProxy bool = true

@description('Switch which allows BGP Propagation to be disabled on the route tables: Default: false')
param parDisableBGPRoutePropagation bool = false

@description('Switch which allows Private DNS Zones to be disabled. Default: true')
param parPrivateDNSZonesEnabled bool = true

param parVpnGatewayConfig object = {}
/*
param parVpnGatewayConfig object = {
  name: '${parCompanyPrefix}-Vpn-Gateway'
  gatewaytype: 'Vpn'
  sku: 'VpnGw1'
  vpntype: 'RouteBased'
  generation: 'Generation1'
  enableBgp: false
  activeActive: false
  enableBgpRouteTranslationForNat: false
  enableDnsForwarding: false
  asn: 65515
  bgpPeeringAddress: ''
  bgpsettings: {
    asn: 65515
    bgpPeeringAddress: ''
    peerWeight: 5
  }
}
*/

param parExpressRouteGatewayConfig object = {}
/*
param parExpressRouteGatewayConfig object = {
  name: '${parCompanyPrefix}-ExpressRoute-Gateway'
  gatewaytype: 'ExpressRoute'
  sku: 'ErGw1AZ'
  vpntype: 'RouteBased'
  vpnGatewayGeneration: 'None'
  enableBgp: false
  activeActive: false
  enableBgpRouteTranslationForNat: false
  enableDnsForwarding: false
  asn: '65515'
  bgpPeeringAddress: ''
  bgpsettings: {
    asn: '65515'
    bgpPeeringAddress: ''
    peerWeight: '5'
  }
}
*/

@description('Prefix value which will be prepended to all resource names. Default: alz')
param parCompanyPrefix string = 'alz'

@description('Azure Bastion SKU or Tier to deploy.  Currently two options exist Basic and Standard. Default: Standard')
param parBastionSku string = 'Standard'

@description('Public IP Address SKU. Default: Standard')
@allowed([
  'Basic'
  'Standard'
])
param parPublicIPSku string = 'Standard'

@description('Tags you would like to be applied to all resources in this module. Default: empty array')
param parTags object = {}

@description('The IP address range for all virtual networks to use. Default: 10.10.0.0/16')
param parHubNetworkAddressPrefix string = '10.10.0.0/16'

@description('Prefix Used for Hub Network. Default: {parCompanyPrefix}-hub-{parRegion}')
param parHubNetworkName string = '${parCompanyPrefix}-hub-${parRegion}'

@description('Azure Firewall Name. Default: {parCompanyPrefix}-azure-firewall ')
param parAzureFirewallName string = '${parCompanyPrefix}-azure-firewall'

@description('Azure Firewall Tier associated with the Firewall to deploy. Default: Standard ')
@allowed([
  'Standard'
  'Premium'
])
param parAzureFirewallTier string = 'Standard'

@description('Name of Route table to create for the default route of Hub. Default: {parCompanyPrefix}-hub-routetable')
param parHubRouteTableName string = '${parCompanyPrefix}-hub-routetable'

@description('The name and IP address range for each subnet in the virtual networks. Default: AzureBastionSubnet, GatewaySubnet, AzureFirewall Subnet')
param parSubnets array = [
  {
    name: 'AzureBastionSubnet'
    ipAddressRange: '10.10.15.0/24'
  }
  {
    name: 'GatewaySubnet'
    ipAddressRange: '10.10.252.0/24'
  }
  {
    name: 'AzureFirewallSubnet'
    ipAddressRange: '10.10.254.0/24'
  }
]

@description('Name Associated with Bastion Service:  Default: {parCompanyPrefix}-bastion')
param parBastionName string = '${parCompanyPrefix}-bastion'

@description('Array of DNS Zones to provision in Hub Virtual Network. Default: All known Azure Private DNS Zones')
param parPrivateDnsZones array = [
  'privatelink.azure-automation.net'
  'privatelink.database.windows.net'
  'privatelink.sql.azuresynapse.net'
  'privatelink.azuresynapse.net'
  'privatelink.blob.core.windows.net'
  'privatelink.table.core.windows.net'
  'privatelink.queue.core.windows.net'
  'privatelink.file.core.windows.net'
  'privatelink.web.core.windows.net'
  'privatelink.dfs.core.windows.net'
  'privatelink.documents.azure.com'
  'privatelink.mongo.cosmos.azure.com'
  'privatelink.cassandra.cosmos.azure.com'
  'privatelink.gremlin.cosmos.azure.com'
  'privatelink.table.cosmos.azure.com'
  'privatelink.${parRegion}.batch.azure.com'
  'privatelink.postgres.database.azure.com'
  'privatelink.mysql.database.azure.com'
  'privatelink.mariadb.database.azure.com'
  'privatelink.vaultcore.azure.net'
  'privatelink.${parRegion}.azmk8s.io'
  '${parRegion}.privatelink.siterecovery.windowsazure.com'
  'privatelink.servicebus.windows.net'
  'privatelink.azure-devices.net'
  'privatelink.eventgrid.azure.net'
  'privatelink.azurewebsites.net'
  'privatelink.api.azureml.ms'
  'privatelink.notebooks.azure.net'
  'privatelink.service.signalr.net'
  'privatelink.afs.azure.net'
  'privatelink.datafactory.azure.net'
  'privatelink.adf.azure.com'
  'privatelink.redis.cache.windows.net'
  'privatelink.redisenterprise.cache.azure.net'
  'privatelink.purview.azure.com'
  'privatelink.digitaltwins.azure.net'
  'privatelink.azconfig.io'
  'privatelink.webpubsub.azure.com'
  'privatelink.azure-devices-provisioning.net'
  'privatelink.cognitiveservices.azure.com'
  'privatelink.azurecr.io'
  'privatelink.search.windows.net'
]

@description('Array of DNS Server IP addresses for VNet. Default: Empty Array')
param parDNSServerIPArray array = []


module deployment 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/hubnetworking:v1.0' = {
  name: 'hubnetworkingdeployment'
  params: {
    parRegion: parRegion
    parBastionEnabled: parBastionEnabled
    parDDoSEnabled: parDDoSEnabled
    parDDoSPlanName: parDDoSPlanName
    parAzureFirewallEnabled: parAzureFirewallEnabled
    parNetworkDNSEnableProxy: parNetworkDNSEnableProxy
    parDisableBGPRoutePropagation: parDisableBGPRoutePropagation
    parPrivateDNSZonesEnabled: parPrivateDNSZonesEnabled
    parVpnGatewayConfig: parVpnGatewayConfig
    parExpressRouteGatewayConfig: parExpressRouteGatewayConfig
    parCompanyPrefix: parCompanyPrefix
    parBastionSku: parBastionSku
    parPublicIPSku: parPublicIPSku
    parTags: parTags
    parHubNetworkAddressPrefix: parHubNetworkAddressPrefix
    parHubNetworkName: parHubNetworkName
    parAzureFirewallName: parAzureFirewallName
    parAzureFirewallTier: parAzureFirewallTier
    parHubRouteTableName: parHubRouteTableName
    parSubnets: parSubnets
    parBastionName: parBastionName
    parPrivateDnsZones: parPrivateDnsZones
    parDNSServerIPArray: parDNSServerIPArray
  }
  scope: resourceGroup(deploymentResourcegroup)
}
