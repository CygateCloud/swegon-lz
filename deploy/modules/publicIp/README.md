# Module: public Ip

## Notes

## Update module image

```powershell
Publish-AzBicepModule `
-FilePath infra-as-code/bicep/modules/publicIp/publicIp.bicep `
-Target br:ccdregistryprod.azurecr.io/bicep/modules/azurefoundation/publicip:v1.0
```
