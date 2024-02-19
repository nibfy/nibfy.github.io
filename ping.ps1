$currentPid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$principal = new-object System.Security.Principal.WindowsPrincipal($currentPid)
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

if ($principal.IsInRole($adminRole))
{
    Clear-Host
    $host.ui.RawUI.WindowTitle = "nibfy.github.io/ping"
}
else
{
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);
    Break
}

$systemInfo = Get-CimInstance Win32_OperatingSystem
Write-Host -NoNewline "llllll  llllll" -ForegroundColor DarkCyan ; Write-Host "  Ping Booster" -ForegroundColor DarkCyan
Write-Host -NoNewline "llllll  llllll" -ForegroundColor DarkCyan ; Write-Host "  (C) nibfy.github.io/ping"-ForegroundColor DarkCyan
Write-Host -NoNewline "llllll  llllll" -ForegroundColor DarkCyan ; Write-Host "  "-ForegroundColor DarkCyan
Write-Host -NoNewline "llllll  llllll" -ForegroundColor DarkCyan ; Write-Host "  " -ForegroundColor DarkCyan
Write-Host -NoNewline "              " -ForegroundColor DarkCyan ; Write-Host "  " -ForegroundColor DarkCyan
Write-Host -NoNewline "llllll  llllll" -ForegroundColor DarkCyan ; Write-Host "  " -ForegroundColor DarkCyan
Write-Host -NoNewline "llllll  llllll" -ForegroundColor DarkCyan ; Write-Host "  " -ForegroundColor DarkCyan
Write-Host -NoNewline "llllll  llllll" -ForegroundColor DarkCyan ; Write-Host "  " -ForegroundColor DarkCyan
Write-Host -NoNewline "llllll  llllll" -ForegroundColor DarkCyan ; Write-Host "  " -ForegroundColor DarkCyan
Write-Host ""

function Type-Slowly {
    param (
        [string]$text,
        [int]$typingSpeed = 25
    )

    foreach ($char in $text.ToCharArray()) {
        Write-Host -NoNewline $char
        Start-Sleep -Milliseconds $typingSpeed
    }
}

Type-Slowly -text "Press ENTER to start the boosting process."
Read-Host

Clear-Host

$ErrorActionPreference = 'Stop'

try
{
    netsh interface ip delete arpcache | Out-Null
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Delete ARPCache" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Delete ARPCache" -ForegroundColor Red
}
try
{
    netsh int tcp set global rsc=disabled >$null
    Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing disabled
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Disable Segment Coalescing Recieving" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Disable Segment Coalescing Recieving" -ForegroundColor Red
}
try
{
    Set-NetOffloadGlobalSetting -PacketCoalescingFilter disabled
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Disable Packet Coalescing" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Disable Packet Coalescing" -ForegroundColor Red
}
try
{
    Enable-NetAdapterChecksumOffload -Name *
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Enable Checksum Offload" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Enable Checksum Offload" -ForegroundColor Red
}
try
{
    Disable-NetAdapterLso -Name *
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Disable Large Send Offload" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Disable Large Send Offload" -ForegroundColor Red
}
try
{
    netsh int tcp set global timestamps=disabled | Out-Null
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Disable RFC 1323 Timestamps" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Disable RFC 1323 Timestamps" -ForegroundColor Red
}
try
{
    netsh int tcp set global initialRto=2500 >$null
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set the Initial RTO to 2500" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set the Initial RTO to 2500" -ForegroundColor Red
}
try
{
    Set-NetTCPSetting -SettingName InternetCustom -MinRto 300
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set the Min RTO to 300" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set the Min RTO to 300" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "2710" /f
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set options in MMCSS" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set options in MMCSS" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NegativeCacheTime" /t REG_DWORD /d "0" /f
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NetFailureCacheTime" /t REG_DWORD /d "0" /f
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NegativeSOACacheTime" /t REG_DWORD /d "0" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set options in DNS Error Caching" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set options in DNS Error Caching" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNS\Parameters" /v "MaximumUdpPacketSize" /t REG_DWORD /d "1280" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set UDP Packet Size to 1280" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set UDP Packet Size to 1280" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Enable RFC 1323 Window Scaling" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Enable RFC 1323 Window Scaling" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableHeuristics" /t REG_DWORD /d "0" /f
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableWsd" /t REG_DWORD /d "0" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Disable Scaling Heuristics in registry" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Disable Scaling Heuristics in registry" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d "0" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set SystemResponsiveness to 0" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set SystemResponsiveness to 0" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d "4294967295" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set Network Throttling Index to 4294967295" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set Network Throttling Index to 4294967295" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d "0" /f
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v Size /t REG_DWORD /d "3" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set Network Memory Allocation" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set Network Memory Allocation" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\QoS" /v "Do not use NLA" /t REG_SZ /d "1" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Disable QoS Policy NLA" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Disable QoS Policy NLA" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d "0" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set QoS Reserved Bandwidth to 0" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set QoS Reserved Bandwidth to 0" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v LocalPriority /t REG_DWORD /d "4" /f
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v HostPriority /t REG_DWORD /d "5" /f
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v DnsPriority /t REG_DWORD /d "6" /f
	reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v NetbtPriority /t REG_DWORD /d "7" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set Host Resolution Priorities" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set Host Resolution Priorities" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /t REG_DWORD /d "30" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set TCPTimedWaitDelay to 30" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set TCPTimedWaitDelay to 30" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d "65534" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set MaxUserPort to 65534" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set MaxUserPort to 65534" -ForegroundColor Red
}
try
{
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d "64" /f
    Write-Host -NoNewline " Success " -BackgroundColor DarkCyan ; Write-Host " Set DefaultTTL to 64" -ForegroundColor DarkCyan
}
catch
{
    Write-Host -NoNewline " Failed " -BackgroundColor Red ; Write-Host " Set DefaultTTL to 64" -ForegroundColor Red
}
Write-Host
Type-Slowly -text "Note: A restart to your pc is recommended for all changes to take full effect." -typingSpeed 15
Write-Host
Write-Host
Write-Host -NoNewline "Press any key to exit.."
Read-Host