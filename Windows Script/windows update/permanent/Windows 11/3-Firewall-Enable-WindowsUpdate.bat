@echo off
:: ============================================
:: 3. WINDOWS DEFENDER FIREWALL
:: Enable Windows Update (hapus rule block)
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
echo   Enable Windows Update - Firewall
echo ============================================
echo.
echo Sedang menghapus rule block Windows Update...
echo.

netsh advfirewall firewall delete rule name="Block Windows Update - wuauserv"
netsh advfirewall firewall delete rule name="Block Windows Update - UsoSvc"
netsh advfirewall firewall delete rule name="Block Windows Update - DoSvc"
netsh advfirewall firewall delete rule name="Block Windows Update - usoclient"
netsh advfirewall firewall delete rule name="Block Windows Update - MoUsoCoreWorker"

echo.
echo Cek sisa rule (kalau kosong berarti sudah bersih)...
netsh advfirewall firewall show rule name=all | findstr /i /c:"Block Windows Update"

echo.
echo [OK] Rule block Windows Update sudah dihapus.
echo     Kalau ada pesan "No rules match", berarti rule-nya memang sudah tidak ada.
echo.
pause
