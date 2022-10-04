# Module: caf-application-owner-role

## Update module image

```powershell
Publish-AzBicepModule `
-FilePath infra-as-code/bicep/modules/customRoleDefinitions/definitions/caf-application-owner-role.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/caf-application-owner-role:v1.0
```
