# Landing zone vending machine

This is a detailed view of how to use the different modules to build a landing zone vending machine.

## Pre reqs
1. SPN must have an Owner role on an Enrollment Account to create a subscription. [Link](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=rest#prerequisites)
2. For creating AAD security groups and assigning to subscription the SPN must have the role "User Administrator" assigned.

## Flow 
1. Create a pipeline: [Template](/deploy/modules/spokeVendingMachine/az-lz-subscription-onboarding.yml)
2. Configure [deploy.ps1](/deploy/modules/spokeVendingMachine/deploy.ps1) with parameters and variables.

