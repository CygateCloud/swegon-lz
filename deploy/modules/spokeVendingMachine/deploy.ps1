
param (
  $AppName,
  $environment,
  $enrollmentAccount,
  $targetManagementGroup,
  $parSpokeNetworkAddressPrefix,
  $parSpokeSubnetNetworkAddressPrefix,
  $parRegion
)

# Params
## Params sub creation
$subscriptionName = "sub-" + $AppName + "-" + $environment
#$environment = "DevTest"
$workloadType = "Production"
$billingaccount = ""
$targetManagementGroupId = "/providers/Microsoft.Management/managementGroups/" + $targetManagementGroup

## Params resource group creation
$parSpokeResourceGroupName = 'rg-network'

## Params network creation
$parBGPRoutePropagation = $false
$parSpokeVirtualNetworkPeerName = 'spoke-to-hub-peering'
$parDNSServerIPArray = '10.100.0.4'
$parNextHopIPAddress = '10.100.0.4'
$parSpokeNetworkName = 'vnet-' + $subscriptionName
$parSpoketoHubRouteTableName = 'rt-' + $subscriptionName
$parSpokeNsgName = 'nsg-' + $subscriptionName
$parHubSubscriptionId = ''
$parHubVnetName = ''
$parHubResourceGroup = ''
$createResourceLock = $false

##Params RBAC creation
$parAssigneePrincipalType = 'Group'

# Deploy subscription with spoke resources
New-AzManagementGroupDeployment `
-Name $subscriptionName `
-Location northeurope `
-ManagementGroupId $targetManagementGroup `
-TemplateFile .\bicep\main.bicep `
-subscriptionAliasName $subscriptionName `
-billingScope "/providers/Microsoft.Billing/BillingAccounts/$billingaccount/enrollmentAccounts/$enrollmentAccount" `
-workload $workloadType `
-parRegion $parRegion `
-parSpokeResourceGroupName $parSpokeResourceGroupName `
-targetManagementGroup $targetManagementGroupId `
-parBGPRoutePropagation $parBGPRoutePropagation `
-parSpokeNetworkAddressPrefix $parSpokeNetworkAddressPrefix `
-parSpokeSubnetNetworkAddressPrefix $parSpokeSubnetNetworkAddressPrefix `
-parSpokeVirtualNetworkPeerName $parSpokeVirtualNetworkPeerName `
-parDNSServerIPArray $parDNSServerIPArray `
-parNextHopIPAddress $parNextHopIPAddress `
-parSpokeNetworkName $parSpokeNetworkName `
-parSpoketoHubRouteTableName $parSpoketoHubRouteTableName `
-parSpokeNsgName $parSpokeNsgName `
-parHubSubscriptionId $parHubSubscriptionId `
-parHubVnetName $parHubVnetName `
-parHubResourceGroup $parHubResourceGroup `
-createResourceLock $createResourceLock #-whatif

# Get output spokeVnetId of newly created vnet
$spokeVnetId = (Get-AzManagementGroupDeployment `
-ManagementGroupId $targetManagementGroup `
-Name $subscriptionName).Outputs.spokeVnetId.value

# Change context and create peering from hub to spoke if not already existing
Set-AzContext -Subscription $parHubSubscriptionId
$spokepeered = $false

$peerings = Get-AzVirtualNetworkPeering -VirtualNetworkName $parHubVnetName -ResourceGroupName $parHubResourceGroup
foreach ($peering in $peerings) {
if ($peering.RemoteVirtualNetwork.id -eq $spokeVnetId){
  $spokepeered = $true
}
}

if ($spokepeered -eq $false) {
$hubPeerName = "hub-app-$($subscriptionName)-$([guid]::NewGuid().Guid.split('-')[0..(-3)] -join "-")"
$hubVnet = Get-AzVirtualNetwork -Name $parHubVnetName -ResourceGroupName $parHubResourceGroup
$PeerHubToSpoke = Add-AzVirtualNetworkPeering `
-AllowGatewayTransit `
-Name $hubPeerName `
-VirtualNetwork $hubVnet `
-RemoteVirtualNetworkId $spokeVnetId

write-host $PeerHubToSpoke
}

else {
write-host 'Spoke already peered'
}

# Assign RBAC permissions
install-module Az.Resources -RequiredVersion '5.4.0' -Scope Currentuser -Force

## Create spoke groups
$subscriptionOwnerSecurityGroupName = $subscriptionName + "-subscriptionOwner"
$ownerGroup = New-AzADGroup `
-DisplayName $subscriptionOwnerSecurityGroupName `
-Description "Security group for subscription owners"  `
-MailNickName "NotSet"
$ownerGroup

$appTeamSecurityGroupName = $subscriptionName + "-appTeamContributors"
$appTeamGroup = New-AzADGroup `
-DisplayName $appTeamSecurityGroupName `
-Description "Security group for application team contributors"  `
-MailNickName "NotSet"
$appTeamGroup

## Get output spokeSubscriptionId of newly created spoke subscription
$subscriptionId = (Get-AzManagementGroupDeployment `
-ManagementGroupId $targetManagementGroup `
-Name $subscriptionName).Outputs.subscriptionId.value

## Give time for security groups to be created
Start-Sleep -Seconds 60

## Changing context to newly created subscription
Set-AzContext -Subscription $subscriptionId
$parOwnerRoleDefinitionId = '8736d87d-8d31-53be-b952-a04c8d470f69'
New-AzDeployment `
-Name 'subowner' `
-Location 'westeurope' `
-TemplateFile ".\bicep\spokeRoleAssignmentSubscription.bicep" `
-parRoleDefinitionId $parOwnerRoleDefinitionId `
-parAssigneePrincipalType $parAssigneePrincipalType `
-parAssigneeObjectId $ownerGroup.Id

$parContributorRoleDefinitionId = '4308c4e6-07d5-534f-9e18-32769872a3f4'
New-AzDeployment `
-Name 'subcontributor' `
-Location 'westeurope' `
-TemplateFile ".\bicep\spokeRoleAssignmentSubscription.bicep" `
-parRoleDefinitionId $parContributorRoleDefinitionId `
-parAssigneePrincipalType $parAssigneePrincipalType `
-parAssigneeObjectId $appTeamGroup.Id