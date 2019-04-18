
FAILING SCENARIO FROM
https://docs.microsoft.com/en-us/dynamics365/customer-engagement/admin/deploy-packages-using-package-deployer-windows-powershell#PD_command


.\PackageDeployer.exe RuntimePackageSettings SkipChecks=true lcid=1045



$Host

Set-ExecutionPolicy -ExecutionPolicy AllSigned



#download nuget
Invoke-WebRequest -Uri https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile nuget.exe


#download nuget package
nuget install Microsoft.CrmSdk.XrmTooling.PackageDeployment.PowerShell -Version 9.0.2.12 -O d:\PD-PowerShell
 .\nuget.exe install Microsoft.CrmSdk.XrmTooling.PackageDeployment.PowerShell -Version 9.0.2.12 -O d:\PD-PowerShell



 cd to this folder and then
 RegisterXRMPackageDeployment.ps1  



 .\nuget.exe install Microsoft.CrmSdk.XrmTooling.PackageDeployment.Wpf -Version 9.0.2.12 -O d:\PD-PowerShell
