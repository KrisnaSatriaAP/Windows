@echo off
:: ============================================
:: Block Windows Update via Firewall
:: Klik kanan file ini -> Run as administrator
:: ============================================

:: Cek apakah dijalankan sebagai Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo [ERROR] Script ini harus dijalankan sebagai Administrator!
    echo Klik kanan file ini, pilih "Run as administrator"
    echo.
    pause
    exit /b
)

echo ============================================
echo   Block Windows Update
echo ============================================
echo.
echo Sedang memblokir Windows Update...

netsh advfirewall firewall delete rule name="Block Windows Update - wuauserv" >nul 2>&1
netsh advfirewall firewall delete rule name="Block Windows Update - usoclient" >nul 2>&1
netsh advfirewall firewall delete rule name="Block Windows Update - UsoSvc" >nul 2>&1

netsh advfirewall firewall add rule name="Block Windows Update - wuauserv" dir=out action=block program="%systemroot%\system32\svchost.exe" service="wuauserv" enable=yes
netsh advfirewall firewall add rule name="Block Windows Update - usoclient" dir=out action=block program="%systemroot%\system32\usoclient.exe" enable=yes
netsh advfirewall firewall add rule name="Block Windows Update - UsoSvc" dir=out action=block program="%systemroot%\system32\svchost.exe" service="UsoSvc" enable=yes

echo.
echo [OK] Windows Update sudah diblokir lewat Firewall.
echo.
pause
