@echo off
echo Disable Real-Time Protection via Group Policy...

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" ^
 /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f

gpupdate /force
echo Done. Restart PC if needed.
pause