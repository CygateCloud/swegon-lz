@description('The Azure Region to deploy the resources into. Default: resourceGroup().location')
param parRegion string = resourceGroup().location

@description('Prefix value which will be prepended to all resource names. Default: alz')
param parCompanyPrefix string = 'alz'

@description('Prefix Used for Hub Network. Default: {parCompanyPrefix}-hub-{parRegion}')
param parHubNetworkName string = '${parCompanyPrefix}-hub-${parRegion}'

@description('The IP address range for all virtual networks to use. Default: 10.10.0.0/16')
param parHubNetworkAddressPrefix string = '10.10.0.0/16'

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

@description('Array of DNS Server IP addresses for VNet. Default: Empty Array')
param parDNSServerIPArray array = []

@description('Public IP Address SKU. Default: Standard')
@allowed([
  'Basic'
  'Standard'
])
param parPublicIPSku string = 'Standard'

@description('Switch which allows Bastion deployment to be disabled. Default: true')
param parBastionEnabled bool = true

@description('Name Associated with Bastion Service:  Default: {parCompanyPrefix}-bastion')
param parBastionName string = '${parCompanyPrefix}-bastion'

@description('Azure Bastion SKU or Tier to deploy.  Currently two options exist Basic and Standard. Default: Standard')
param parBastionSku string = 'Standard'




@description('Switch which allows DDOS deployment to be disabled. Default: true')
param parDDoSEnabled bool = false

@description('DDOS Plan Name. Default: {parCompanyPrefix}-DDos-Plan')
param parDDoSPlanName string = '${parCompanyPrefix}-DDoS-Plan'

@description('Switch which allows Azure Firewall deployment to be disabled. Default: true')
param parAzureFirewallEnabled bool = true

@description('Azure Firewall Name. Default: {parCompanyPrefix}-azure-firewall ')
param parAzureFirewallName string = '${parCompanyPrefix}-azure-firewall'

@description('Azure Firewall Policies Name. Default: {parCompanyPrefix}-fwpol-{parRegion}')
param parAzFirewallPoliciesName string = '${parCompanyPrefix}-azfwpolicy-${parRegion}'

@description('Azure Firewall Tier associated with the Firewall to deploy. Default: Standard ')
@allowed([
  'Standard'
  'Premium'
])
param parAzureFirewallTier string = 'Standard'









@description('Switch which enables DNS Proxy to be enabled on the Azure Firewall. Default: true')
param parNetworkDNSEnableProxy bool = true

@description('Name of Route table to create for the default route of Hub. Default: {parCompanyPrefix}-hub-routetable')
param parHubRouteTableName string = '${parCompanyPrefix}-hub-routetable'

@description('Switch which allows BGP Propagation to be disabled on the route tables: Default: false')
param parDisableBGPRoutePropagation bool = false

@description('Switch which allows Private DNS Zones to be disabled. Default: true')
param parPrivateDNSZonesEnabled bool = true

@description('Resource Group Name for Private DNS Zones. Default: same resource group')
param parPrivateDnsZonesResourceGroup string = resourceGroup().name

@description('Array of DNS Zones to provision in Hub Virtual Network. Default: All known Azure Private DNS Zones')
param parPrivateDnsZones array = [
  'privatelink.azure-automation.net'
  'privatelink.database.windows.net'
  'privatelink.sql.azuresynapse.net'
  'privatelink.dev.azuresynapse.net'
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
  'privatelink.${toLower(parRegion)}.batch.azure.com'
  'privatelink.postgres.database.azure.com'
  'privatelink.mysql.database.azure.com'
  'privatelink.mariadb.database.azure.com'
  'privatelink.vaultcore.azure.net'
  'privatelink.managedhsm.azure.net'
  'privatelink.${toLower(parRegion)}.azmk8s.io'
  'privatelink.siterecovery.windowsazure.com'
  'privatelink.servicebus.windows.net'
  'privatelink.azure-devices.net'
  'privatelink.eventgrid.azure.net'
  'privatelink.azurewebsites.net'
  'privatelink.api.azureml.ms'
  'privatelink.notebooks.azure.net'
  'privatelink.service.signalr.net'
  'privatelink.monitor.azure.com'
  'privatelink.oms.opinsights.azure.com'
  'privatelink.ods.opinsights.azure.com'
  'privatelink.agentsvc.azure-automation.net'
  'privatelink.afs.azure.net'
  'privatelink.datafactory.azure.net'
  'privatelink.adf.azure.com'
  'privatelink.redis.cache.windows.net'
  'privatelink.redisenterprise.cache.azure.net'
  'privatelink.purview.azure.com'
  'privatelink.purviewstudio.azure.com'
  'privatelink.digitaltwins.azure.net'
  'privatelink.azconfig.io'
  'privatelink.cognitiveservices.azure.com'
  'privatelink.azurecr.io'
  'privatelink.search.windows.net'
  'privatelink.azurehdinsight.net'
  'privatelink.media.azure.net'
  'privatelink.his.arc.azure.com'
  'privatelink.guestconfiguration.azure.com'
]

//ASN must be 65515 if deploying VPN & ER for co-existence to work: https://docs.microsoft.com/en-us/azure/expressroute/expressroute-howto-coexist-resource-manager#limits-and-limitations
@description('''Configuration for VPN virtual network gateway to be deployed. If a VPN virtual network gateway is not desired an empty object should be used as the input parameter in the parameter file, i.e. 
"parVpnGatewayConfig": {
  "value": {}
}''')
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

@description('''Configuration for ExpressRoute virtual network gateway to be deployed. If a ExpressRoute virtual network gateway is not desired an empty object should be used as the input parameter in the parameter file, i.e. 
"parExpressRouteGatewayConfig": {
  "value": {}
}''')
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

@description('Tags you would like to be applied to all resources in this module. Default: empty array')
param parTags object = {}




var varSubnetProperties = [for subnet in parSubnets: {
  name: subnet.name
  properties: {
    addressPrefix: subnet.ipAddressRange
  }
}]




var varVpnGWConfig = ((!empty(parVpnGatewayConfig)) ? parVpnGatewayConfig : json('{"name": "noconfigVpn"}'))

var varErGWConfig = ((!empty(parExpressRouteGatewayConfig)) ? parExpressRouteGatewayConfig : json('{"name": "noconfigEr"}'))

var varGwConfig = [
  varVpnGWConfig
  varErGWConfig
]




resource resDDoSProtectionPlan 'Microsoft.Network/ddosProtectionPlans@2021-02-01' = if (parDDoSEnabled) {
  name: parDDoSPlanName
  location: parRegion
  tags: parTags
}

//DDos Protection plan will only be enabled if parDDoSEnabled is true.  
resource resHubVirtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: parHubNetworkName
  location: parRegion
  tags: parTags
  properties: {
    addressSpace: {
      addressPrefixes: [
        parHubNetworkAddressPrefix
      ]
    }
    dhcpOptions: {
      dnsServers: parDNSServerIPArray
    }
    subnets: varSubnetProperties
    enableDdosProtection: parDDoSEnabled
    ddosProtectionPlan: (parDDoSEnabled) ? {
      id: resDDoSProtectionPlan.id
    } : null
  }
}




module modBastionPublicIP 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/publicip:v1.0' = if (parBastionEnabled) {
  name: 'deploy-Bastion-Public-IP'
  params: {
    parLocation: parRegion
    parPublicIPName: '${parBastionName}-PublicIP'
    parPublicIPSku: {
      name: parPublicIPSku
    }
    parPublicIPProperties: {
      publicIPAddressVersion: 'IPv4'
      publicIPAllocationMethod: 'Static'
    }
    parTags: parTags
  }
}


resource resBastionSubnetRef 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' existing = {
  parent: resHubVirtualNetwork
  name: 'AzureBastionSubnet'
}































































































































// AzureBastionSubnet is required to deploy Bastion service. This subnet must exist in the parsubnets array if you enable Bastion Service.
// There is a minimum subnet requirement of /27 prefix.  
// If you are deploying standard this needs to be larger. https://docs.microsoft.com/en-us/azure/bastion/configuration-settings#subnet
resource resBastion 'Microsoft.Network/bastionHosts@2021-02-01' = if (parBastionEnabled) {
  location: parRegion
  name: parBastionName
  tags: parTags
  sku: {
    name: parBastionSku
  }
  properties: {
    dnsName: uniqueString(resourceGroup().id)
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: resBastionSubnetRef.id
          }
          publicIPAddress: {
            id: parBastionEnabled ? modBastionPublicIP.outputs.outPublicIPID : ''
          }
        }
      }
    ]
  }
}

resource resGatewaySubnetRef 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' existing = {
  parent: resHubVirtualNetwork
  name: 'GatewaySubnet'
}

module modGatewayPublicIP 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/publicip:v1.0' = [for (gateway, i) in varGwConfig: if ((gateway.name != 'noconfigVpn') && (gateway.name != 'noconfigEr')) {
  name: 'deploy-Gateway-Public-IP-${i}'
  params: {
    parLocation: parRegion
    parPublicIPName: '${gateway.name}-PublicIP'
    parPublicIPProperties: {
      publicIPAddressVersion: 'IPv4'
      publicIPAllocationMethod: 'Static'
    }
    parPublicIPSku: {
      name: parPublicIPSku
    }
    parTags: parTags
  }
}]


//Minumum subnet size is /27 supporting documentation https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#gwsub
resource resGateway 'Microsoft.Network/virtualNetworkGateways@2021-02-01' = [for (gateway, i) in varGwConfig: if ((gateway.name != 'noconfigVpn') && (gateway.name != 'noconfigEr')) {
  name: gateway.name
  location: parRegion
  tags: parTags
  properties: {
    activeActive: gateway.activeActive
    enableBgp: gateway.enableBgp
    enableBgpRouteTranslationForNat: gateway.enableBgpRouteTranslationForNat
    enableDnsForwarding: gateway.enableDnsForwarding
    bgpSettings: (gateway.enableBgp) ? gateway.bgpSettings : null
    gatewayType: gateway.gatewayType
    vpnGatewayGeneration: (gateway.gatewayType == 'VPN') ? gateway.generation : 'None'
    vpnType: gateway.vpntype
    sku: {
      name: gateway.sku
      tier: gateway.sku
    }
    ipConfigurations: [
      {
        id: resHubVirtualNetwork.id
        name: 'vnetGatewayConfig'
        properties: {
          publicIPAddress: {
            id: (((gateway.name != 'noconfigVpn') && (gateway.name != 'noconfigEr')) ? modGatewayPublicIP[i].outputs.outPublicIPID : 'na')
          }
          subnet: {
            id: resGatewaySubnetRef.id
          }
        }
      }
    ]
  }
}]

resource resAzureFirewallSubnetRef 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' existing = {
  parent: resHubVirtualNetwork
  name: 'AzureFirewallSubnet'
}

module modAzureFirewallPublicIP 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/publicip:v1.0' = if (parAzureFirewallEnabled) {
  name: 'deploy-Firewall-Public-IP'
  params: {
    parLocation: parRegion
    parPublicIPName: '${parAzureFirewallName}-PublicIP'
    parPublicIPProperties: {
      publicIPAddressVersion: 'IPv4'
      publicIPAllocationMethod: 'Static'
    }
    parPublicIPSku: {
      name: parPublicIPSku
    }
    parTags: parTags
  }
}



resource resFirewallPolicies 'Microsoft.Network/firewallPolicies@2021-08-01' = if (parAzureFirewallEnabled) {
  name: parAzFirewallPoliciesName
  location: parRegion
  tags: parTags
  properties: {
    dnsSettings: {
      enableProxy: parNetworkDNSEnableProxy

    }
    sku: {
      tier: parAzureFirewallTier
    }
  }
}

// AzureFirewallSubnet is required to deploy Azure Firewall . This subnet must exist in the parsubnets array if you deploy.
// There is a minimum subnet requirement of /26 prefix.  
resource resAzureFirewall 'Microsoft.Network/azureFirewalls@2021-02-01' = if (parAzureFirewallEnabled) {
  name: parAzureFirewallName
  location: parRegion
  tags: parTags
  properties: {
    networkRuleCollections: [
      {
        name: 'VmInternetAccess'
        properties: {
          priority: 101
          action: {
            type: 'Allow'
          }
          rules: [
            {
              name: 'AllowVMAppAccess'
              description: 'Allows VM access to the web'
              protocols: [
                'TCP'
              ]
              sourceAddresses: [
                parHubNetworkAddressPrefix
              ]
              destinationAddresses: [
                '*'
              ]
              destinationPorts: [
                '80'
                '443'
              ]
            }
          ]
        }
      }
    ]
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: resAzureFirewallSubnetRef.id
          }
          publicIPAddress: {
            id: parAzureFirewallEnabled ? modAzureFirewallPublicIP.outputs.outPublicIPID : ''
          }
        }
      }
    ]
    threatIntelMode: 'Alert'
    sku: {
      name: 'AZFW_VNet'
      tier: parAzureFirewallTier
    }
    firewallPolicy: {
      id: resFirewallPolicies.id
    }
  }
}

//If Azure Firewall is enabled we will deploy a RouteTable to redirect Traffic to the Firewall.
resource resHubRouteTable 'Microsoft.Network/routeTables@2021-02-01' = if (parAzureFirewallEnabled) {
  name: parHubRouteTableName
  location: parRegion
  tags: parTags
  properties: {
    routes: [
      {
        name: 'udr-default-azfw'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: parAzureFirewallEnabled ? resAzureFirewall.properties.ipConfigurations[0].properties.privateIPAddress : ''
        }
      }
    ]
    disableBgpRoutePropagation: parDisableBGPRoutePropagation
  }
}



module modPrivateDnsZones '../privateDnsZones/privateDnsZones.bicep' = if (parPrivateDNSZonesEnabled) {
  name: 'deploy-Private-DNS-Zones'
  scope: resourceGroup(parPrivateDnsZonesResourceGroup)
  params: {
    parLocation: parRegion
    parTags: parTags
    parVirtualNetworkIdToLink: resHubVirtualNetwork.id
    parPrivateDnsZones: parPrivateDnsZones
  }
}

//If Azure Firewall is enabled we will deploy a RouteTable to redirect Traffic to the Firewall.
output outAzureFirewallPrivateIP string = parAzureFirewallEnabled ? resAzureFirewall.properties.ipConfigurations[0].properties.privateIPAddress : ''

//If Azure Firewall is enabled we will deploy a RouteTable to redirect Traffic to the Firewall.
output outAzureFirewallName string = parAzureFirewallEnabled ? parAzureFirewallName : ''

output outPrivateDnsZones array = (parPrivateDNSZonesEnabled ? modPrivateDnsZones.outputs.outPrivateDnsZones : [])

output outDDoSPlanResourceID string = resDDoSProtectionPlan.id
output outHubVirtualNetworkName string = resHubVirtualNetwork.name
output outHubVirtualNetworkID string = resHubVirtualNetwork.id
