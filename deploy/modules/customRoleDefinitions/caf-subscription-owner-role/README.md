# Module: caf-subscription-owner-role

## Update module image

```powershell
Publish-AzBicepModule `
-FilePath infra-as-code/bicep/modules/customRoleDefinitions/definitions/caf-subscription-owner-role.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/caf-subscription-owner-role:v1.0
```
