@echo off
echo Disable Windows Update...
net stop wuauserv
sc config wuauserv start= disabled
echo Done
pause