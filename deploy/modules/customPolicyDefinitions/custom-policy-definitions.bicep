targetScope = 'managementGroup'
param parTargetManagementGroupID string = 'estosv'

module deployment 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/custompolicydefinitions:v1.0' = {
  name: 'policydefinitionsdeployment'
  params: {
    parTargetManagementGroupID: parTargetManagementGroupID
  }
  scope: managementGroup()
}
