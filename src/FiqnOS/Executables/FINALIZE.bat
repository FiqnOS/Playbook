@echo off
setlocal EnableDelayedExpansion

setx DOTNET_CLI_TELEMETRY_OPTOUT 1
setx POWERSHELL_TELEMETRY_OPTOUT 1

for %%a in ( EnhancedPowerManagementEnabled AllowIdleIrpInD3 EnableSelectiveSuspend DeviceSelectiveSuspended SelectiveSuspendEnabled SelectiveSuspendOn WaitWakeEnabled D3ColdSupported WdfDirectedPowerTransitionEnable EnableIdlePowerManagement IdleInWorkingState) do for /f "delims=" %%b in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum" /s /f "%%a" ^| findstr "HKEY"') do Reg.exe add "%%b" /v "%%a" /t REG_DWORD /d "0" /f

PowerShell -NonInteractive -NoLogo -NoProfile -Command "Disable-MMAgent -mc | Disable-WindowsErrorReporting | Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | ForEach-Object { $_.enable = $false; $_.psbase.put(); }"

label C: FiqnOS
bcdedit /set {current} description "FiqnOS"
bcdedit /set {globalsettings} custom:16000067 true
bcdedit /set {globalsettings} custom:16000068 true
bcdedit /set {globalsettings} custom:16000069 true
bcdedit /deletevalue useplatformclock
bcdedit /deletevalue disabledynamictick
bcdedit /set noumex Yes
bcdedit /set bootems No
bcdedit /set isolatedcontext No
bcdedit /set vsmlaunchtype Off
bcdedit /set vm No
bcdedit /set testsigning No
bcdedit /set allowedinmemorysettings 0
bcdedit /set perfmem 0
bcdedit /set configflags 0
bcdedit /set nolowmem Yes
bcdedit /set nx optin
bcdedit /set pae ForceDisable
bcdedit /set x2apicpolicy Enable
bcdedit /set bootux Disabled
bcdedit /set tpmbootentropy ForceDisable
bcdedit /set usephysicaldestination No
bcdedit /set halbreakpoint No
bcdedit /set bootmenupolicy legacy

PowerShell -NonInteractive -NoLogo -NoProfile -Command "Disable-MMAgent -mc | Disable-WindowsErrorReporting | Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | ForEach-Object { $_.enable = $false; $_.psbase.put(); }"

powershell -NoProfile -Command "Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6, ms_msclient, ms_server, ms_rspndr, ms_lltdio, ms_implat, ms_lldp"

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SysMain" /v "start" /t REG_DWORD /d "4" /f

for /f "delims=" %%u in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces" /s /f "NetbiosOptions" ^| findstr "HKEY"') do (
    reg add "%%u" /v "NetbiosOptions" /t REG_DWORD /d "2" /f
)

fsutil behavior set disable8dot3 1
fsutil behavior set disablelastaccess 1
fsutil behavior set disabledeletenotify 0
fsutil behavior set memoryusage 2
