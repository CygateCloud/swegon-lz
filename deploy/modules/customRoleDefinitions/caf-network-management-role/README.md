# Module: caf-network-management-role

## Update module image

```powershell
Publish-AzBicepModule `
-FilePath infra-as-code/bicep/modules/customRoleDefinitions/definitions/caf-network-management-role.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/caf-network-management-role:v1.0
```
