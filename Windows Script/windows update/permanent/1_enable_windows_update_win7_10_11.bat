@echo off
echo Enable Windows Update...
sc config wuauserv start= demand
net start wuauserv
echo Done
pause