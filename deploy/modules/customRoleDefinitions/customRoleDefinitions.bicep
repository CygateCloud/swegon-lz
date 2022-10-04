targetScope = 'managementGroup'
param parAssignableScopeManagementGroupId string = 'estosv'

module deployment 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/customroledefinitions:v1.0' = {
  name: 'roledefinitionsdeployment'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
  scope: managementGroup()
}
