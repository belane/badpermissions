##
## Service|Process|Task bad permissions checker
## 15/09/16
##

function checkModify ($path)
    {
    Try {
    if (((Get-Acl $path -ErrorAction SilentlyContinue).Access | ?{$_.IdentityReference -eq "$env:USERDOMAIN\$env:USERNAME"}).FileSystemRights -match 'FullControl|Modify|Write')
        {
        return $true
        }
    $mgroups = ((Get-Acl $path -ErrorAction SilentlyContinue).Access | ?{$_.FileSystemRights -match 'FullControl|Modify|Write'}).IdentityReference.value|
        ForEach { $_.Split("\") | select -Last 1 }
    foreach ($mgroup in $mgroups)
        {
        if($localgroupsmember -contains $mgroup)
            {
            return $true
            break
            }
        }
    return $false
    }
    Catch {return $false}
    }

Clear-Host
$banner = @"

 _         _                      _         _             
| |_ ___ _| |   ___ ___ ___ _____|_|___ ___|_|___ ___ ___ 
| . | .'| . |  | . | -_|  _|     | |_ -|_ -| | . |   |_ -|
|___|__,|___|  |  _|___|_| |_|_|_|_|___|___|_|___|_|_|___|
               |_| 
__________________________________________________belane__

"@
$banner


$logfile = "BP_"+[Environment]::MachineName+"-"+$env:username+".txt"
Write-Host "[i] Log file:" $logfile
Write-Host "[ ] "
("bad permissions log file`r`n------------------------") | out-file -filepath $logfile

Write-Host "[i] Current User:" $env:username
("Current User: "+$env:username) | out-file -filepath $logfile -append
Write-Host "[+] Current User Membership"
"User Membership:" | out-file -filepath $logfile -append
$Server = [Environment]::MachineName
$localgroups = Get-WMIObject win32_group -filter "LocalAccount='True'" -computername $Server |
    Select PSComputername,Name,@{Name="Members";Expression={
    $_.GetRelated("win32_useraccount").Name -join ";"
    }}
$localgroupsmember = @()
foreach ($localgroup in $localgroups) {
    if ($localgroup.Members -match $env:username)
        {
        $localgroupsmember += $localgroup.Name
        Write-Host "[ ] -" $localgroup.Name
        ("`t"+$localgroup.Name) | out-file -filepath $logfile -append
        }
    }
Write-Host "[ ] "
"`r" | out-file -filepath $logfile -append

$processes = Get-Process | where {$_.Path} | select -ExpandProperty Path | sort -Unique
Write-Host "[+] Cheking" $processes.Count "Process ..."
foreach ($process in $processes)
    {
    if(checkModify ($process))
        {
        Write-Host "[!]  Found vulnerable:" $process
        ("Rights on Process "+$process)| out-file -filepath $logfile -append
        }
    }
Write-Host "[ ] "


$services = Get-WmiObject win32_service | where {$_.Pathname} |
    ForEach {$_.Pathname.Substring(0, $_.Pathname.IndexOf(".exe")+4).Replace("`"", "")
    } | sort -Unique
Write-Host "[+] Cheking" $services.Count "Services ..."
foreach ($service in $services)
    {
    if(checkModify ($service))
        {
        Write-Host "[!]  Found vulnerable:" $service
        ("Rights on Service "+$service)| out-file -filepath $logfile -append
        }
    }
Write-Host "[ ] "


$tasks = Get-ScheduledTask | ? {$_.State.value -ne "Disabled"} |
    ForEach-Object { $_.Actions.execute} | sort -Unique
Write-Host "[+] Cheking" $tasks.Count "Scheduled Tasks ..."
foreach ($task in $tasks)
    {
    if(checkModify ($task))
        {
        Write-Host "[!]  Found vulnerable:" $task
        ("Rights on Task "+$task)| out-file -filepath $logfile -append
        }
    }
Write-Host "[ ] "


Write-Host "[ ] "
Write-Host "[ ] Done"
"`r`nEOF" | out-file -filepath $logfile -append
