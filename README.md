---
languages:
- csharp
- aspx-csharp
page_type: sample
description: "This is a sample application that you can use to follow along with the Run a RESTful API with CORS in Azure App Service tutorial."
products:
- azure
- aspnet-core
- azure-app-service
---

# ASP.NET Core API sample for Azure App Service

This is a sample application that you can use to follow along with the tutorial at 
[Run a RESTful API with CORS in Azure App Service](https://docs.microsoft.com/azure/app-service/app-service-web-tutorial-rest-api). 

## License

See [LICENSE](https://github.com/Azure-Samples/dotnet-core-api/blob/master/LICENSE.md).

## Contributing

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
  
## How to deploy to AKS

Start Docker Desktop for Windows, and ensure docker engine is "Running".

If you get errors about Hyper-V service, just restart the VM.

Ensure you have proper access to the AKS cluster by running the command below.

```
C:\Users\user1234\msdocs-python-django-webapp-quickstart>kubectl cluster-info
Kubernetes control plane is running at https://aks947255-0qn6qdec.041ea12c-d11d-4611-a797-4e0278b1dc3a.privatelink.eastus.azmk8s.io:443
CoreDNS is running at https://aks947255-0qn6qdec.041ea12c-d11d-4611-a797-4e0278b1dc3a.privatelink.eastus.azmk8s.io:443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://aks947255-0qn6qdec.041ea12c-d11d-4611-a797-4e0278b1dc3a.privatelink.eastus.azmk8s.io:443/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

C:\Users\user1234\msdocs-python-django-webapp-quickstart>
```

If AKS access is not OK, run the aks.ps1 powershell script on your desktop, which will configure your vm with the correct access to AKS.

Note that the aks.ps1 script will login to your azure account, so please login once asked to do so.

After aks.ps1 script runs, check again that AKS is OK for you.

Run the following commands to build and deploy the sample application in AKS.

```
az acr login --name <acr-name>.azurecr.io
cd c:\users\<username>\msdocs-python-django-webapp-quickstart
docker build -t <acr-name>/dotnet-demo .
docker push <acr-name>/dotnet-demo
kubctl apply -f deploy.yaml
kubectl get deployment
kubectl get pods
kubectl get service
kubectl get endpoints
curl <endpoint-ip>:5000
```

Open your web browser and go to http://<endpoint-ip>:5000, you should see the application frontend, so you can test it is functional.
