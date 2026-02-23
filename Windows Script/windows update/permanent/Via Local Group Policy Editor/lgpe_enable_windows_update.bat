@echo off
echo Enable Windows Update...

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f

gpupdate /force

echo Done
pause