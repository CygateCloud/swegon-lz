# Module: caf-security-operations-role

## Update module image

```powershell
Publish-AzBicepModule `
-FilePath infra-as-code/bicep/modules/customRoleDefinitions/definitions/caf-security-operations-role.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/caf-security-operations-role:v1.0
```
