@echo off
echo Enable Guest Access SMB...

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation" ^
 /v AllowInsecureGuestAuth /t REG_DWORD /d 1 /f

gpupdate /force
echo Done. Restart PC if needed.
pause