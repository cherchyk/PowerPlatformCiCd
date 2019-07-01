
### local2crm
$solutionDir =  [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, "..\"))
Write-Host "Solution Dir: " $solutionDir -ForegroundColor Green

$slnZip = [System.IO.Path]::Combine($solutionDir, "solution.zip")
Write-Host "Solution file: " $slnZip -ForegroundColor Green

Import-CrmSolution -conn $CRMConn -SolutionFilePath $slnZip

Publish-CrmAllCustomization -conn $CRMConn

Write-Host "..."
Write-Host "Completed"
##########################################################################################