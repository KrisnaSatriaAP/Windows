@echo off
echo Disable Firewall...
netsh advfirewall set allprofiles state off
echo Done
pause