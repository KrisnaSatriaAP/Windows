# Tutorial Cek Log di Windows

Panduan praktis untuk melihat, memfilter, dan mengekspor log di Windows. Cocok untuk troubleshooting PC/server (koneksi putus, restart sendiri, service mati, driver bermasalah, dan sejenisnya).

> **Catatan:** Jalankan CMD/PowerShell sebagai **Administrator** supaya semua log (terutama *Security*) bisa dibaca.

---

## 1. Event Viewer (Cara GUI)

Event Viewer adalah tool bawaan Windows untuk membaca log sistem.

### Cara membuka

Pilih salah satu:

- Tekan `Win + R`, ketik `eventvwr.msc`, lalu Enter
- Klik kanan tombol Start → **Event Viewer**
- Cari "Event Viewer" di menu Start

### Struktur log yang penting

Buka **Windows Logs** di panel kiri:

| Log | Isi |
|---|---|
| **Application** | Error/warning dari aplikasi |
| **System** | Driver, service, hardware, network adapter, restart/shutdown |
| **Security** | Login berhasil/gagal, audit akses |
| **Setup** | Instalasi update dan fitur Windows |

Log tambahan ada di **Applications and Services Logs → Microsoft → Windows**, misalnya `WLAN-AutoConfig`, `DNS-Client`, `Kernel-PnP`, dan lain-lain.

### Level event

| Level | Arti |
|---|---|
| Critical | Masalah fatal (sistem crash/mati mendadak) |
| Error | Ada fungsi yang gagal |
| Warning | Potensi masalah |
| Information | Aktivitas normal |

### Filter log supaya tidak kebanjiran

1. Klik log yang diinginkan (misal **System**)
2. Panel kanan → **Filter Current Log...**
3. Pilih **Logged** (rentang waktu), centang **Critical / Error / Warning**
4. Opsional: isi **Event ID** atau pilih **Event sources**
5. Klik **OK**

Untuk pencarian kata kunci (misal nama NIC), gunakan **Find...** di panel kanan.

### Simpan log dari GUI

Panel kanan → **Save Filtered Log File As...** (format `.evtx`), atau **Save All Events As...** dan pilih tipe **Text (Tab delimited)** atau **CSV** kalau ingin dibaca di Notepad/Excel.

---

## 2. PowerShell (Cara Cepat)

Lebih efisien kalau mau filter banyak kondisi atau ekspor ke file teks.

### Lihat 50 event terbaru dari log System

```powershell
Get-WinEvent -LogName System -MaxEvents 50
```

### Tampilkan hanya Error dan Critical dalam 24 jam terakhir

```powershell
Get-WinEvent -FilterHashtable @{
    LogName   = 'System'
    Level     = 1,2
    StartTime = (Get-Date).AddHours(-24)
}
```

> Kode level: `1` = Critical, `2` = Error, `3` = Warning, `4` = Information.

### Filter berdasarkan Event ID

```powershell
Get-WinEvent -FilterHashtable @{ LogName='System'; Id=41,6008,1074 }
```

### Filter berdasarkan kata kunci pada pesan

```powershell
Get-WinEvent -LogName System -MaxEvents 2000 |
    Where-Object { $_.Message -match 'Realtek|network|link' } |
    Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, Message
```

### Ekspor hasil ke file teks

```powershell
Get-WinEvent -FilterHashtable @{ LogName='System'; Level=1,2,3; StartTime=(Get-Date).AddDays(-3) } |
    Format-List TimeCreated, Id, LevelDisplayName, ProviderName, Message |
    Out-File D:\log_system_3hari.txt -Encoding utf8
```

### Ekspor ke CSV (enak dibuka di Excel)

```powershell
Get-WinEvent -FilterHashtable @{ LogName='System'; Level=1,2; StartTime=(Get-Date).AddDays(-7) } |
    Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, Message |
    Export-Csv D:\log_system_7hari.csv -NoTypeInformation -Encoding utf8
```

---

## 3. CMD dengan `wevtutil`

Alternatif kalau tidak mau memakai PowerShell.

```cmd
:: Lihat 20 event terbaru log System dalam format teks (terbaru di atas)
wevtutil qe System /c:20 /rd:true /f:text

:: Ekspor seluruh log System ke file .evtx
wevtutil epl System D:\System.evtx

:: Daftar semua nama log yang tersedia
wevtutil el
```

File `.evtx` hasil ekspor bisa dibuka lagi di Event Viewer (**Action → Open Saved Log...**) pada PC lain, jadi praktis untuk dikirim ke tim atau vendor.

### Hapus log (hati-hati)

```cmd
wevtutil cl System
```

Perintah ini menghapus seluruh isi log. **Backup dulu** (`wevtutil epl`) sebelum menghapus, karena data tidak bisa dikembalikan.

---

## 4. Event ID yang Sering Dicari

### Restart / shutdown / crash

| Event ID | Log | Arti |
|---|---|---|
| 41 | System | *Kernel-Power*: sistem reboot tanpa shutdown bersih (mati listrik, hang, crash) |
| 1074 | System | Shutdown/restart diinisiasi user atau proses |
| 6005 | System | Event Log service mulai (tanda PC baru menyala) |
| 6006 | System | Event Log service berhenti (shutdown normal) |
| 6008 | System | Shutdown sebelumnya tidak terduga |
| 1001 | System | *BugCheck*: PC pernah BSOD |

### Service

| Event ID | Arti |
|---|---|
| 7034 | Service berhenti mendadak |
| 7036 | Service berubah status (running/stopped) |
| 7031 | Service berhenti dan akan di-restart otomatis |

### Login (log Security)

| Event ID | Arti |
|---|---|
| 4624 | Login berhasil |
| 4625 | Login gagal |
| 4634 / 4647 | Logoff |
| 4800 / 4801 | Workstation di-lock / di-unlock |

### Lainnya

| Event ID | Arti |
|---|---|
| 10016 | Error permission DCOM (umumnya aman diabaikan) |
| 219 | Driver gagal dimuat |
| 20001 | Instalasi driver perangkat |

---

## 5. Log Lain di File Sistem

Tidak semua log ada di Event Viewer. Beberapa ada sebagai file:

| Lokasi | Isi |
|---|---|
| `C:\Windows\Logs\CBS\CBS.log` | Log komponen Windows (SFC/DISM, update) |
| `C:\Windows\INF\setupapi.dev.log` | Log instalasi driver/perangkat |
| `C:\Windows\Minidump\` | File dump saat BSOD |
| `C:\Windows\MEMORY.DMP` | Full memory dump |
| `C:\Windows\Logs\WindowsUpdate\` | Log Windows Update (format ETL) |

Untuk mengubah log Windows Update ke teks yang bisa dibaca:

```powershell
Get-WindowsUpdateLog
```

File hasilnya muncul di Desktop (`WindowsUpdate.log`).

---

## 6. Reliability Monitor

Tool ini menampilkan riwayat kestabilan sistem dalam bentuk grafik, sangat membantu untuk melihat **kapan** masalah mulai muncul.

- Tekan `Win + R`, ketik `perfmon /rel`, lalu Enter
- Titik silang merah = kegagalan (crash aplikasi, update gagal, dan lain-lain)
- Klik pada tanggal untuk melihat detailnya

---

## 7. Alur Troubleshooting yang Disarankan

1. **Tentukan waktu kejadian** (misal: koneksi putus jam 10:15)
2. Buka **Event Viewer → System**, filter **Error + Warning** di rentang waktu tersebut
3. Perhatikan kolom **Source** dan **Event ID** yang muncul berulang
4. Cek **Application** kalau masalahnya terkait aplikasi tertentu
5. Cocokkan dengan **Reliability Monitor** untuk melihat pola
6. Ekspor log ke `.evtx`/`.txt`/`.csv` sebagai bukti dan bahan analisis
7. Cari Event ID/pesan error tersebut untuk menemukan penyebab dan solusinya

---

## 8. Tips

- Ekspor log **sebelum** PC di-restart atau di-reinstall, karena ukuran log terbatas dan data lama bisa tertimpa.
- Naikkan ukuran maksimum log kalau sering kehilangan data lama: klik kanan log → **Properties → Maximum log size**.
- Gunakan **Create Custom View** di Event Viewer untuk menyimpan filter yang sering dipakai.
- Pantau pola berulang (misal event yang sama tiap beberapa menit), karena sering lebih informatif daripada satu event tunggal.
- Untuk banyak PC/server, pertimbangkan **Windows Event Forwarding** atau kirim log ke sistem terpusat (syslog/SIEM).

---

## Referensi Cepat

```text
eventvwr.msc                          -> buka Event Viewer
perfmon /rel                          -> Reliability Monitor
Get-WinEvent -LogName System -MaxEvents 50
wevtutil epl System D:\System.evtx    -> ekspor log
```
