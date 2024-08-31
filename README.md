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

If you get errors about Hyper-V service or user not belonging to docker-users group, just restart the VM.

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
cd c:\users\<username>\desktop\msdocs-python-django-webapp-quickstart
docker build -t <acr-name>/dotnet-demo .
docker push <acr-name>/dotnet-demo
```
If docker push gives unauthorized error run the below command to login to azure contaienr registry
```
az acr login --name <acr-name>.azurecr.io
docker push <acr-name>/dotnet-demo
```
After docker image is pushed successfuly, modify the <acr-name> in the deploy.yaml file like below
```
spec:
 template:
   spec:
     containers:
     - name: dotnet-demo
       image: <acr-name>.azurecr.io/dotnet-demo
```
After updating deploy.yaml, deploy the application using the commands below
```
C:\Users\user1234\Desktop\dotnet-core-api>kubectl apply -f deploy.yaml
deployment.apps/dotnet-demo-deployment created
service/dotnet-demo-service created
C:\Users\user1234\Desktop\dotnet-core-api>kubectl get pods
NAME                                      READY   STATUS    RESTARTS   AGE
dotnet-demo-deployment-689dc8d6bf-v9std   1/1     Running   0          2m23s
C:\Users\user1234\Desktop\dotnet-core-api>kubectl get svc
NAME                  TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
dotnet-demo-service   ClusterIP   10.0.216.132   <none>        5000/TCP   2m28s
kubernetes            ClusterIP   10.0.0.1       <none>        443/TCP    116m
C:\Users\user1234\Desktop\dotnet-core-api>kubectl get ep
NAME                  ENDPOINTS          AGE
dotnet-demo-service   10.224.0.26:5000   2m34s   <<< endpoint-ip = 10.224.0.26
kubernetes            10.224.0.6:443     116m
```

Open your web browser and go to http://<endpoint-ip>:5000, you should see the application frontend, so you can test it is functional.
