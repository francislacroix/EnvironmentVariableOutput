resource "azapi_resource" "appservice_container" {
  type = "Microsoft.Web/sites/sitecontainers@2024-04-01"
  name = var.ContainerName

  parent_id = var.AppServiceID
 
  body = {    
    properties = {
      authType = "SystemIdentity"
      userManagedIdentityClientId = "SystemIdentity"
      image = var.ContainerImage
      isMain = var.IsMainContainer
      targetPort = var.TargetPort
      environmentVariables = var.EnvironmentVaribles
      volumeMounts = var.volumeMounts
    }
  }
}