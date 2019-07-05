$envServiceAccountUpn = "bocherch@bocherch.onmicrosoft.com"
$envServiceAccountPassword = "sK455w0r0"
$envEnvironmentUrl = "cibc-hs-2.crm3.dynamics.com"

$connectionstring = "AuthType = Office365;
				Username = $envServiceAccountUpn;
				Password = $envServiceAccountPassword;
				Url = https://$envEnvironmentUrl"

$connectione = Get-CrmConnection -ConnectionString $connectionstring

$connectione