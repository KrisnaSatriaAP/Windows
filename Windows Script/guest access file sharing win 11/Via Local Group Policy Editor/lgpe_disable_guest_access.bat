@echo off
echo Disable Guest Access SMB...

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation" ^
 /v AllowInsecureGuestAuth /t REG_DWORD /d 0 /f

gpupdate /force
echo Done
pause