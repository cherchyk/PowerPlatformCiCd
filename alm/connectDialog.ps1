### CONNECT
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

$Global:CRMConn = Get-CrmConnection -InteractiveMode

#$connectionHost = "https://cibc-hs-2.crm3.dynamics.com/"
#$organizationName = "CIBC Horizon&Smart 2"
#$DeploymentRegion = "CAN"

#works
#$cred = Get-Credential
#$CRMOrgs = Get-CrmOrganizations -ServerUrl $connectionHost -Credential $Cred
#$CRMOrgs  

#issues
#$Global:CRMConn = Get-CrmConnection -ServerUrl $connectionHost -Credential $Cred -OrganizationName $organizationName
#$Global:CRMConn = Get-CrmConnection -OrganizationName $organizationName -Credential $cred -DeploymentRegion $DeploymentRegion -OnlineType Office365  
#$CRMConn = Get-CrmConnection -Credential $cred -ServerUrl $connectionHost -OrganizationName $organizationName
#$CRMConn = Get-CrmConnection -ConnectionString "Url=https://cibcdemo2.crm3.dynamics.com/;UserName=sssssss;Password=ssssssssssss"
####Connect-CrmOnline -Credential $cred -ServerUrl $connectionHost -OrganizationName $organizationName
#Get-CrmConnection -OrganizationName $organizationName -OnLineType Office365 -Credential $cred
#$CRMOrgs = Get-CrmOrganizations -Credential $cred -DeploymentRegion CAN -OnlineType Office365

Write-Host "Successfully connected." -ForegroundColor Green
Write-Host ("   User: " + $cred.UserName) -ForegroundColor Green
Write-Host ("   Org: " + $CRMConn.CrmConnectOrgUriActual) -ForegroundColor Green
$CRMConn
##########################################################################################