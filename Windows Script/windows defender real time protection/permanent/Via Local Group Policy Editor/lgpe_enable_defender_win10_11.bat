@echo off
echo Enable Real-Time Protection via Group Policy...

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" ^
 /v DisableRealtimeMonitoring /f

gpupdate /force
echo Done. Restart PC if needed.
pause