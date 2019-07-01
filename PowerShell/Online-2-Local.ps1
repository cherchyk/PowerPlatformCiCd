### crm2local
$solutionName = "samplesolution"

$solutionDir = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, "..\"))
#$slnZip = $solutionName + ".zip"
$slnZip = "solution.zip"

Write-Host ("Org: " + $CRMConn.CrmConnectOrgUriActual) -ForegroundColor Green
Write-Host "Solution Name: " $solutionName -ForegroundColor Green
Write-Host "Solution Dir: " $solutionDir -ForegroundColor Green
Write-Host "Solution file: " $slnZip -ForegroundColor Green

Export-CrmSolution -conn $CRMConn -SolutionName $solutionName -SolutionFilePath $solutionDir -SolutionZipFileName $slnZip
##########################################################################################

