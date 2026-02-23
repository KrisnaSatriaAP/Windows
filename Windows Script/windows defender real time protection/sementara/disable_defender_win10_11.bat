@echo off
echo Disable Real-Time Protection...
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"
echo Done
pause