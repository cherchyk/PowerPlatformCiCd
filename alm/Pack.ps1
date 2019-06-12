
### package

$PackageType = "Unmanaged"

$solutionDir =  [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, "..\"))
Write-Host "Solution Dir:      " $solutionDir -ForegroundColor Green

$SolutionPackager = [System.IO.Path]::Combine($solutionDir, "packages\Microsoft.CrmSdk.CoreTools.9.0.3.1\content\bin\coretools\SolutionPackager.exe")
Write-Host "Solution Packager: " $SolutionPackager -ForegroundColor Green

$slnZip = [System.IO.Path]::Combine($solutionDir, "solution.zip")
Write-Host "Solution file:     " $slnZip -ForegroundColor Green

$SolutionPath = [System.IO.Path]::Combine($solutionDir, "SolutionPackage\package")
Write-Host "Solution Path:     " $SolutionPath -ForegroundColor Green

$MapFile = [System.IO.Path]::Combine($solutionDir, "SolutionPackage\map.xml")
Write-Host "Map File:          " $MapFile -ForegroundColor Green


& $SolutionPackager /action: Pack /zipfile: $slnZip /folder: $SolutionPath   /map: $MapFile  /packagetype: $PackageType


##########################################################################################