@echo off
setlocal EnableDelayedExpansion

setx DOTNET_CLI_TELEMETRY_OPTOUT 1 & setx POWERSHELL_TELEMETRY_OPTOUT 1

for %%a in (
	EnhancedPowerManagementEnabled
	AllowIdleIrpInD3
	EnableSelectiveSuspend
	DeviceSelectiveSuspended
	SelectiveSuspendEnabled
	SelectiveSuspendOn
	EnumerationRetryCount
	ExtPropDescSemaphore
	WaitWakeEnabled
	D3ColdSupported
	WdfDirectedPowerTransitionEnable
	EnableIdlePowerManagement
	IdleInWorkingState
	fid_D1Latency
	fid_D2Latency
	fid_D3Latency
	IoLatencyCap
	DmaRemappingCompatible
	DmaRemappingCompatibleSelfhost
) do for /f "delims=" %%b in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "%%b" ^| findstr "HKEY"') do reg add "%%b" /v "%%b" /t REG_DWORD /d "0" /f >nul

bcdedit /set disabledynamictick yes
bcdedit /deletevalue useplatformclock
bcdedit /deletevalue useplatformtick
bcdedit /set noumex Yes
bcdedit /set bootems No
bcdedit /set ems No
bcdedit /set bootlog No
bcdedit /set hypervisorlaunchtype No
bcdedit /set isolatedcontext No
bcdedit /set vsmlaunchtype Off
bcdedit /set vm No
bcdedit /set quietboot Yes
bcdedit /set integrityservices disable
bcdedit /set nx optin
bcdedit /set pae ForceDisable
bcdedit /set x2apicpolicy Enable
bcdedit /set bootux Disabled
bcdedit /set halbreakpoint No
bcdedit /set bootmenupolicy legacy
bcdedit /set tscsyncpolicy Enhanced
bcdedit /set uselegacyapicmode No
bcdedit /set loadoptions DISABLE-LSA-ISO,DISABLE-VBS
bcdedit /set {current} description "FiqnOS"
label C: FiqnOS
cls

Reg.exe add "HKLM\SOFTWARE\Microsoft\Input" /v "InputServiceEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input" /v "InputServiceEnabledForCCI" /t REG_DWORD /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f >nul
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul
powershell disable-netadapterbinding -Name "*" -componentid "vmware_brige, ms_lldp, ms_lltdio, ms_implat, ms_tcpip6, ms_rspndr, ms_server, ms_msclient"
reg delete "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /f && reg add "HKLM\System\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /f >nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Tpm" /v "Start" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WinPhoneCritical" /v "Start" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Office\Common\ClientTelemetry" /v "DisableTelemetry" /t REG_DWORD /d "1" /f

setlocal

set autologgers=autologger-diagtrack-listener,cellcore,cloudexperiencehostoobe,lwtnetlog,melanos-Kernel,microsoft-windows-assignedacces-trace,microsoft-windows-rdp-graphics-rdpidd-trace,microsoft-windows-setup,netcore,ntfslog,peauthlog,radiomgr,readyboot,refslog,setupplatform,setupplatformtel,spoolerlogger,tcpiplogger,wifisession,wifidriverhvsessionrepro,wifidriverihvsession,wfp-ipsec-trace,ubpm,tilestore

for %%Q in (%autologgers%) do (
    powershell -Command "Remove-AutologgerConfig -Name %%~Q"
)

endlocal

PowerShell -NonInteractive -NoLogo -NoProfile -Command "Disable-MMAgent -mc | Disable-WindowsErrorReporting | Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | ForEach-Object { $_.enable = $false; $_.psbase.put(); }"

powershell -NoProfile -Command "Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6, ms_msclient, ms_server, ms_rspndr, ms_lltdio, ms_implat, ms_lldp"
PowerShell -command "Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | ForEach-Object { $_.enable = $false; $_.psbase.put(); }"

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SysMain" /v "start" /t REG_DWORD /d "4" /f

for /f "delims=" %%u in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces" /s /f "NetbiosOptions" ^| findstr "HKEY"') do (
    reg add "%%u" /v "NetbiosOptions" /t REG_DWORD /d "2" /f
)

fsutil behavior set disable8dot3 1
fsutil behavior set disablelastaccess 1
fsutil behavior set disabledeletenotify 0
fsutil behavior set encryptpagingfile 0
fsutil behavior set disablecompression 1
fsutil behavior set memoryusage 2
