# Module: Spoke Networking v1.0

This module defines spoke networking based on the recommendations from the Azure Landing Zone Conceptual Architecture. If enabled spoke will route traffic to Hub Network with NVA.

Module can deploy the following resources:

- Virtual Network (Spoke VNet)
- Subnets
- UDR - if Firewall is enabled
- Default Network Security Group
- Default Route Table
- Virtual Network peering to Hub
- Resource Group Lock

## Update image
```
Publish-AzBicepModule `
-FilePath infra-as-code\bicep\modules\spokeNetworking\spokeNetworking.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/spokenetworking:v1.0
```

## Parameters

The module requires the following inputs:

 | Parameter                    | Type   | Default                    | Description                                                         | Requirement | Example                                                                                                                                               |
 | ---------------------------- | ------ | -------------------------- | ------------------------------------------------------------------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
 | parRegion                    | string | `resourceGroup().location` | The Azure Region to deploy the resources into                       | None        | `eastus`                                                                                                                                              |
 | parBGPRoutePropagation       | bool   | false                      | Switch to enable BGP Route Propagation on VNet Route Table          | None        | false                                                                                                                                                 |
 | parTags                      | object | Empty object `{}`          | Array of Tags to be applied to all resources in the Spoke Network   | None        | `{"key": "value"}`                                                                                                                                    |
 | parSpokeNetworkAddressPrefix | string | '10.11.0.0/16'             | CIDR for Spoke Network                                              | None        | '10.11.0.0/16'                                                                                                                                        |
 | parSpokeSubnetNetworkAddressPrefix | string | '10.11.0.0/25'             | CIDR for Spoke Network default subnet                                              | None        | '10.11.0.0/25'                                                                                                                                        |
 | parSpokeVirtualNetworkName          | string | 'vnet-spoke'               | The Name of the Spoke Virtual Network.                              | None        | 'vnet-spoke'                                                                                                                                          |
 | parSpokeVirtualNetworkPeerName          | string | 'spoke-to-hub-peering'               | The Name of the Spoke Virtual Network peering to the hub.                              | None        | 'spoke-to-hub-peering'                                                                                                                                          |
 | parDNSServerIPArray          | array  | Empty array `[]`           | Array IP DNS Servers to use for VNet DNS Resolution                 | None        | `['10.10.1.4', '10.20.1.5']`                                                                                                                          |
 | parNextHopIPAddress          | string | Empty string `''`          | IP Address where network traffic should route to leverage DNS Proxy | None        | '192.168.50.4'                                                                                                                                        |
 | parSpokeToHubRouteTableName  | string | 'rt-spoke-to-hub'         | Name of Route table to create for the default route of Hub.         | None        | 'rt-spoke-to-hub '                                                                                                                                   |
 | parSpokeNsgName  | string | 'nsg-spoke'         | Name of Network security group to create for the default route of Hub.         | None        | 'nsg-spoke'                                                                                                                                   |
 | parHubVnetName  | string | 'hub-vnet'         | Name of Hub virtual network.         | None        | 'hub-vnet'                                                                                                                                   |
 | parHubSubscriptionId  | string | None         | Subscription ID of Hub.         | None        | None                                                                                                                                   |
 | parHubResourceGroup  | string | 'hub-networking'         | Name of Hub resource group.         | None        | 'hub-networking'                                                                                                                                   |
 | createResourceLock  | bool | false         | Switch to create resource lock on network resource group.         | None        | false                                                                                                                                   |

## Deployment

In this example, the spoke resources will be deployed to the resource group specified. According to the Azure Landing Zone Conceptual Architecture, the spoke resources should be deployed into the Landing Zones subscriptions. 

> For the examples below we assume you have downloaded or cloned the Git repo as-is and are in the root of the repository as your selected directory in your terminal of choice.

> If deployment crashes on DDoS protection Id the subscription might be affected by policy "Virtual networks should be protected by Azure DDoS Protection Standard".

### PowerShell

```powershell
$LandingZoneSubscriptionId = "ec4b5f97-92b3-499f-8dfd-eb203abf540a"
$resourcegroupname = 'spoke-vnet'
$parNextHopIPAddress = '10.10.1.4'
$parHubSubscriptionId = '739c615c-b090-470c-b2f9-6ecebff1ac01'
$parHubVnetName = 'estosv-hub-westeurope'
$parHubResourceGroup = 'Hub_Networking_POC'

Select-AzSubscription -SubscriptionId $LandingZoneSubscriptionId

New-AzResourceGroup -Name $resourcegroupname `
-Location 'westeurope'

New-AzResourceGroupDeployment `
-TemplateFile deploy\modules\spoke\spokeNetworking.bicep `
-ResourceGroupName $resourcegroupname `
-parHubVnetName $parHubVnetName `
-parHubSubscriptionId $parHubSubscriptionId `
-parHubResourceGroup $parHubResourceGroup `
-parNextHopIPAddress $parNextHopIPAddress `
-WhatIf
```

# Module: Spoke Networking v1.1
Append update information.