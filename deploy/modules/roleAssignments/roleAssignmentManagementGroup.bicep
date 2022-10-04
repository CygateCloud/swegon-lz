targetScope = 'managementGroup'

@description('A GUID representing the role assignment name.  Default:  guid(managementGroup().name, parRoleDefinitionId, parAssigneeObjectId)')
param parRoleAssignmentNameGuid string = guid(managementGroup().name, parRoleDefinitionId, parAssigneeObjectId)

@description('Role Definition Id (i.e. GUID, Reader Role Definition ID:  acdd72a7-3385-48ef-bd42-f606fba81ae7)')
param parRoleDefinitionId string

@description('Principal type of the assignee.  Allowed values are \'Group\' (Security Group) or \'ServicePrincipal\' (Service Principal or System/User Assigned Managed Identity)')
@allowed([
  'Group'
  'ServicePrincipal'
])
param parAssigneePrincipalType string

@description('Object ID of groups, service principals or managed identities. For managed identities use the principal id. For service principals, use the object ID and not the app ID')
param parAssigneeObjectId string

module deployment 'br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/roleassigmentmanagementgroup:v1.0' = {
  name: 'policydefinitionsdeployment'
  params: {
    parRoleAssignmentNameGuid: parRoleAssignmentNameGuid
    parRoleDefinitionId: parRoleDefinitionId
    parAssigneePrincipalType: parAssigneePrincipalType
    parAssigneeObjectId: parAssigneeObjectId
  }
  scope: managementGroup()
}
