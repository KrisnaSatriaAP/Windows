@echo off
echo Disable Windows Update via Local Group Policy...

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" ^
 /v NoAutoUpdate /t REG_DWORD /d 1 /f

gpupdate /force

echo Done
pause