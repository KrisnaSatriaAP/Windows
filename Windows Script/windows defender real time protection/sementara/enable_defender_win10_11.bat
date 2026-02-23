@echo off
echo Enable Real-Time Protection...
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $false"
echo Done
pause