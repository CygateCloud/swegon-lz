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

