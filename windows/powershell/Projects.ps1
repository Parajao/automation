Add-Type -TypeDefinition @"
[System.Flags]
public enum Project
{
    None = 0,
    Automation = 1,
    Common = 2,
    Slumber = 4,
    All = Automation + Common + Slumber
}
"@

function global:Get-Projects {
    return @{ 
        [Project]::Automation = [PSCustomObject]@{ Git = "git@github.com:sensemaking/automation.git"; Directory = "~\automation"; Script = $null; VsSolution = $null; CodeSolution = "~\automation"; HasJs = $false; };
        [Project]::Common = [PSCustomObject]@{ Git = "git@github.com:sensemaking/common.git"; Directory = "~\common"; Script = $null; VsSolution = "~\common\Common.sln"; CodeSolution = $null; HasJs = $false; };
        [Project]::Slumber = [PSCustomObject]@{ Git = "git@github.com:sensemaking/slumber.git"; Directory = "~\Slumber"; Script = $null; VsSolution = "~\Slumber\Slumber.sln"; CodeSolution = "~\Slumber\Host\Ui\Web\src"; HasJs = $true; };
    }
}

function global:Update-Projects { 
   $automationDir =((get-projects).GetEnumerator() | where { $_.Name -eq "Automation" }).Value.Directory 
   $profileDir = Split-Path $PROFILE
   
   if(!(Test-Path $automationDir)){ clone Automation }

   pull Automation
 
   Copy-Item "$automationDir\windows\powershell\Projects.ps1" -Destination "$profileDir\Projects.ps1" -fo
   powershell.exe -nologo
}