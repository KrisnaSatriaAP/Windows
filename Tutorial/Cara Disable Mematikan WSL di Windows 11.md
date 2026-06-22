# Cara Disable/Mematikan WSL di Windows 11

---

## Cara 1 — Via PowerShell (Recommended)

Buka PowerShell as Administrator, lalu jalankan perintah berikut:

```powershell
# Matikan semua instance WSL yang lagi jalan
wsl --shutdown

# Disable fitur WSL
dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
```

> Restart PC setelahnya.

---

## Cara 2 — Via Windows Features (GUI)

1. Tekan **Win + R** → ketik `optionalfeatures` → Enter
2. Cari dan **uncheck**:
   - `Windows Subsystem for Linux`
   - `Virtual Machine Platform` (kalau mau bersih total)
3. Klik OK → Restart

---

## Cara 3 — Stop Sementara (Tanpa Uninstall)

Kalau cuma mau matiin WSL tanpa disable permanen:

```powershell
wsl --shutdown
```

Untuk menjalankan WSL lagi:

```powershell
wsl
```

---

## Perbandingan

| Cara | Efek | WSL bisa dipakai lagi? |
|---|---|---|
| `wsl --shutdown` | Stop sementara | ✅ Langsung |
| Disable via dism/features | Permanen sampai di-enable lagi | Perlu enable ulang + restart |
