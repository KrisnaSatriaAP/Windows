@echo off
:: ============================================
:: Enable Windows Update via Firewall
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
echo   Enable Windows Update
echo ============================================
echo.
echo Sedang menghapus rule blokir Windows Update...

netsh advfirewall firewall delete rule name="Block Windows Update - wuauserv" >nul 2>&1
netsh advfirewall firewall delete rule name="Block Windows Update - usoclient" >nul 2>&1
netsh advfirewall firewall delete rule name="Block Windows Update - UsoSvc" >nul 2>&1

echo.
echo [OK] Windows Update sudah aktif/enable kembali.
echo.
pause
