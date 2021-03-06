function Ssh-SignIn{
    Stop-Process -Name 'ssh-agent' -ErrorAction SilentlyContinue
        
    & "$env:programFiles\Git\usr\bin\ssh-agent.exe" | % {
        if ($_ -match '(?<key>[^=]+)=(?<value>[^;]+);') {
            [void][Environment]::SetEnvironmentVariable($Matches['key'], $Matches['value'])
        }
    }

    & "$env:programFiles\Git\usr\bin\ssh-add.exe" $env:USERPROFILE\.ssh\sm_rsa
}

function Status([Project] $project = [Project]::All){
    function Show-Status($targetProject){
        Write-Host `nStatus for $targetProject.Key -Fore Green
        Set-Location $targetProject.Value.Directory
        git status .
    } 

    $dir = Get-Location
    (Get-Projects).GetEnumerator() | Where-Object { $project.HasFlag($_.Key) } | % { Show-Status $_ }
    Set-Location $dir
}

function Pull ([Project] $project = [Project]::All){
    function Git-Pull($targetProject){
        Write-Host `nPulling $targetProject.Key -Fore Green
        Set-Location $targetProject.Value.Directory
        git pull
    }

    $dir = Get-Location
    (Get-Projects).GetEnumerator() | Where-Object { $project.HasFlag($_.Key) } | % { Git-Pull $_ }
    Set-Location $dir
}

function Push ([Project] $project = [Project]::None, $message = "_", [Switch] $noBuild){
    function Git-Push($targetProject){
        Write-Host `nCommitting $targetProject.Key -Fore Green
        Set-Location $targetProject.Value.Directory        
        git add .
        git commit . -m $message --no-status
        git push 
    }
  
    $dir = Get-Location 
    (Get-Projects).GetEnumerator() | Where-Object { $project.HasFlag($_.Key) } | % { 
        if (!$noBuild) { Build $_.Key }
        Git-Push $_ 
    }
    Set-Location $dir
}

function Revert ([Project] $project = [Project]::None){
    function Git-Revert($targetProject){
        Write-Host `nReverting $targetProject.Key -Fore Green
        Set-Location $targetProject.Value.Directory

        git reset --hard origin/master 
        git clean -qf
    }

    $dir = Get-Location
    (Get-Projects).GetEnumerator() | Where-Object { $project.HasFlag($_.Key) } | % { Git-Revert $_ }
    Set-Location $dir
}

function Clone([Project] $project = [Project]::None) {
    function Git-Clone($targetProject) {
        Write-Host `nCloning $targetProject.Key -Fore Green
        Set-Location ~
        git clone $targetProject.Value.Git         
    }

    $dir = Get-Location
    (Get-Projects).GetEnumerator() | Where-Object { $project.HasFlag($_.Key) } | % { Git-Clone $_ }
    Set-Location $dir
}