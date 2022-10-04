targetScope = 'tenant'

param parTopLevelManagementGroupDisplayName string = 'estosv'
param parTopLevelManagementGroupPrefix string = 'estosv'

module deployment 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/managementgroups:v1.1' = {
  name: 'managementgroupsdeployment'
  params: {
    parTopLevelManagementGroupPrefix: parTopLevelManagementGroupPrefix
    parTopLevelManagementGroupDisplayName: parTopLevelManagementGroupDisplayName
  }
  scope: tenant()
}
