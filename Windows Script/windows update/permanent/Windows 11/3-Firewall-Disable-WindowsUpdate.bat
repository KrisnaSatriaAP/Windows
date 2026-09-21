@echo off
:: ============================================
:: 3. WINDOWS DEFENDER FIREWALL
:: Block Windows Update via Firewall Rules
:: Klik kanan file ini -> Run as administrator
:: ============================================

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
echo   Block Windows Update - Firewall
echo ============================================
echo.
echo Sedang memblokir Windows Update lewat Firewall...

:: Hapus rule lama biar gak dobel
netsh advfirewall firewall delete rule name="Block Windows Update - wuauserv" >nul 2>&1
netsh advfirewall firewall delete rule name="Block Windows Update - UsoSvc" >nul 2>&1
netsh advfirewall firewall delete rule name="Block Windows Update - DoSvc" >nul 2>&1
netsh advfirewall firewall delete rule name="Block Windows Update - usoclient" >nul 2>&1
netsh advfirewall firewall delete rule name="Block Windows Update - MoUsoCoreWorker" >nul 2>&1

:: Buat rule block outbound untuk semua service/proses terkait Windows Update
netsh advfirewall firewall add rule name="Block Windows Update - wuauserv" dir=out action=block program="%systemroot%\system32\svchost.exe" service="wuauserv" enable=yes
netsh advfirewall firewall add rule name="Block Windows Update - UsoSvc" dir=out action=block program="%systemroot%\system32\svchost.exe" service="UsoSvc" enable=yes
netsh advfirewall firewall add rule name="Block Windows Update - DoSvc" dir=out action=block program="%systemroot%\system32\svchost.exe" service="DoSvc" enable=yes
netsh advfirewall firewall add rule name="Block Windows Update - usoclient" dir=out action=block program="%systemroot%\system32\usoclient.exe" enable=yes
netsh advfirewall firewall add rule name="Block Windows Update - MoUsoCoreWorker" dir=out action=block program="%systemroot%\system32\MoUsoCoreWorker.exe" enable=yes

:: Block juga akses ke domain resmi Windows Update via IP range Microsoft (opsional, blok domain by hosts kalau perlu)
echo.
echo [OK] Windows Update sudah diblokir lewat Windows Defender Firewall.
echo     Rule yang dibuat: wuauserv, UsoSvc, DoSvc, usoclient.exe, MoUsoCoreWorker.exe
echo.
pause
