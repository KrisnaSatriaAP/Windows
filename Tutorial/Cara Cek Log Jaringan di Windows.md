# Tutorial Cek Log Jaringan di Windows

Panduan khusus untuk menelusuri masalah jaringan di Windows: koneksi putus-nyambung, NIC reset, IP conflict, DHCP/DNS bermasalah, dan Wi-Fi yang tidak stabil.

> **Catatan:** Jalankan PowerShell/CMD sebagai **Administrator**. Nama *source* dan Event ID bisa sedikit berbeda antar versi Windows dan vendor driver, jadi selalu cocokkan dengan kolom **Source** dan isi pesan pada event.

---

## 1. Lokasi Log Jaringan di Event Viewer

Buka dengan `Win + R` → `eventvwr.msc`.

### Log utama

| Lokasi | Isi |
|---|---|
| **Windows Logs → System** | Event driver NIC (link up/down), Tcpip, DHCP, DNS, service jaringan |
| **Applications and Services Logs → Microsoft → Windows → NetworkProfile → Operational** | Riwayat koneksi/diskoneksi jaringan |
| **Applications and Services Logs → Microsoft → Windows → Dhcp-Client → Admin** | Aktivitas DHCP client |
| **Applications and Services Logs → Microsoft → Windows → DNS-Client → Operational** | Masalah resolusi DNS |
| **Applications and Services Logs → Microsoft → Windows → WLAN-AutoConfig → Operational** | Koneksi Wi-Fi (khusus adapter wireless) |
| **Applications and Services Logs → Microsoft → Windows → NDIS → Operational** | Reset/link status adapter di level driver jaringan |

> Beberapa log di atas kadang belum aktif secara default. Kalau kosong, klik kanan log → **Enable Log**. Untuk log bertipe *Analytic/Debug*, aktifkan dulu lewat menu **View → Show Analytic and Debug Logs**.

### Source (Provider) yang perlu diperhatikan

| Source | Keterangan |
|---|---|
| **Tcpip** | Masalah IP stack (misal IP address conflict) |
| **NDIS** | Reset atau perubahan status network adapter |
| **Dhcp / Microsoft-Windows-Dhcp-Client** | Gagal dapat IP, lease, dan sejenisnya |
| **DNS Client Events** | Timeout resolusi nama |
| **NetworkProfile** | Jaringan terhubung/terputus |
| **Nama driver NIC** (Realtek, Intel, dan lain-lain) | Pesan *link is disconnected/connected*, reset, error hardware |
| **Microsoft-Windows-Kernel-PnP** | Adapter di-disable/enable atau dicabut/dipasang |

---

## 2. Event ID Jaringan yang Sering Dicari

| Log / Source | Event ID | Arti |
|---|---|---|
| NetworkProfile | 10000 | Jaringan terhubung |
| NetworkProfile | 10001 | Jaringan terputus |
| Tcpip | 4199 | Terdeteksi IP address conflict |
| DNS Client Events | 1014 | Resolusi nama timeout |
| WLAN-AutoConfig | 8001 | Berhasil terhubung ke Wi-Fi |
| WLAN-AutoConfig | 8003 | Terputus dari Wi-Fi |
| NDIS | 10400 | Adapter jaringan sedang di-reset (biasanya disertai alasan reset) |

Untuk event link up/down dari driver NIC, pola pesannya biasanya mirip "*network link is disconnected*" atau "*network link has been established*". ID-nya berbeda tiap vendor, jadi paling aman filter berdasarkan **Source** driver NIC atau kata kunci pada pesan.

---

## 3. Filter Cepat di Event Viewer

1. Klik **Windows Logs → System**
2. Panel kanan → **Filter Current Log...**
3. Pada **Event sources**, pilih `Tcpip`, `NDIS`, `Dhcp`, dan driver NIC yang dipakai
4. Atur **Logged** ke rentang waktu kejadian (misal *Last 24 hours*)
5. Centang **Critical / Error / Warning**, lalu **OK**

Alternatif: gunakan **Find...** dan cari kata `link`, `disconnected`, `reset`, atau nama NIC (misal `Realtek`).

---

## 4. Cek Log Jaringan dengan PowerShell

### Event dari source jaringan di log System (3 hari terakhir)

```powershell
Get-WinEvent -FilterHashtable @{
    LogName      = 'System'
    ProviderName = 'Tcpip','NDIS','Dhcp','Microsoft-Windows-DNS-Client'
    StartTime    = (Get-Date).AddDays(-3)
} | Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, Message
```

### Cari event berdasarkan kata kunci (link, reset, disconnect, nama NIC)

```powershell
Get-WinEvent -LogName System -MaxEvents 5000 |
    Where-Object { $_.Message -match 'link|disconnect|reset|Realtek|adapter' } |
    Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, Message
```

### Riwayat koneksi/diskoneksi jaringan

```powershell
Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-NetworkProfile/Operational'
    Id      = 10000,10001
} | Select-Object TimeCreated, Id, Message
```

### Log DHCP client

```powershell
Get-WinEvent -LogName 'Microsoft-Windows-Dhcp-Client/Admin' -MaxEvents 100 |
    Select-Object TimeCreated, Id, LevelDisplayName, Message
```

### Cek log jaringan apa saja yang tersedia di PC

```powershell
Get-WinEvent -ListLog *Network*, *NDIS*, *Dhcp*, *DNS*, *WLAN* |
    Select-Object LogName, IsEnabled, RecordCount
```

### Ekspor hasil ke file teks

```powershell
Get-WinEvent -FilterHashtable @{
    LogName      = 'System'
    ProviderName = 'Tcpip','NDIS','Dhcp'
    StartTime    = (Get-Date).AddDays(-7)
} | Format-List TimeCreated, Id, LevelDisplayName, ProviderName, Message |
    Out-File D:\log_jaringan.txt -Encoding utf8
```

---

## 5. Cek Status Adapter Saat Ini

```powershell
# Status, kecepatan link, dan driver tiap adapter
Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, LinkSpeed, DriverVersion

# Statistik paket (cek error/discard)
Get-NetAdapterStatistics

# Konfigurasi IP
ipconfig /all

# Cek sampai ke gateway dan internet
Test-NetConnection 8.8.8.8
```

Kolom **Status** yang sering berubah antara `Up` dan `Disconnected` menandakan link fisik/driver tidak stabil (kabel, port switch, NIC, atau power saving).

---

## 6. Log Wi-Fi (Khusus Adapter Wireless)

Windows bisa membuat laporan riwayat Wi-Fi dalam bentuk HTML:

```cmd
netsh wlan show wlanreport
```

File laporan ada di `C:\ProgramData\Microsoft\Windows\WlanReport\wlan-report-latest.html` dan menampilkan sesi koneksi, alasan terputus, serta grafik 3 hari terakhir.

---

## 7. Log Firewall (Opsional)

Kalau dicurigai ada koneksi yang diblok firewall Windows, aktifkan pencatatan:

```cmd
netsh advfirewall set allprofiles logging droppedconnections enable
netsh advfirewall set allprofiles logging filename "%systemroot%\system32\LogFiles\Firewall\pfirewall.log"
```

Log tersimpan di `C:\Windows\System32\LogFiles\Firewall\pfirewall.log`. Matikan lagi setelah selesai agar ukuran file tidak membengkak:

```cmd
netsh advfirewall set allprofiles logging droppedconnections disable
```

---

## 8. Monitoring Real-time Sebagai Pembanding Log

Log Event Viewer lebih berguna kalau dicocokkan dengan bukti putusnya koneksi. Jalankan ping kontinu dengan timestamp ke gateway (atau server tujuan):

```powershell
ping -t 192.168.1.1 | ForEach-Object { "{0}  {1}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $_ } | Tee-Object D:\ping_log.txt
```

Ganti `192.168.1.1` dengan IP gateway. Saat ada `Request timed out`, catat jamnya lalu cocokkan dengan event di Event Viewer pada waktu yang sama.

### Capture paket bawaan Windows (tanpa Wireshark)

```cmd
netsh trace start capture=yes tracefile=D:\jaringan.etl maxsize=512
:: ... tunggu masalah terjadi ...
netsh trace stop
```

File `.etl` bisa dikonversi atau dibuka dengan tool seperti Microsoft Message Analyzer/etl2pcapng untuk dianalisis di Wireshark.

---

## 9. Alur Troubleshooting Jaringan

1. **Catat waktu kejadian** (misal koneksi putus jam 10:15)
2. Jalankan `ping -t` ke gateway dengan timestamp (bagian 8) untuk bukti pembanding
3. Buka **Event Viewer → System**, filter source jaringan pada rentang waktu itu
4. Cari event **link disconnected / adapter reset / NDIS** tepat sebelum koneksi putus
5. Cek **NetworkProfile (10000/10001)** untuk memastikan pola putus-nyambung
6. Jika ada reset NIC berulang, cek **Device Manager → properti NIC → Power Management** (matikan *Allow the computer to turn off this device to save power*) dan perbarui driver
7. Lihat juga sisi lain: kabel LAN, port switch, dan log perangkat (switch/router)
8. Ekspor log ke `.txt`/`.csv`/`.evtx` sebagai bahan analisis

---

## Referensi Cepat

```text
eventvwr.msc                                  -> buka Event Viewer
Get-NetAdapter                                -> status adapter
ipconfig /all                                 -> konfigurasi IP
netsh wlan show wlanreport                    -> laporan Wi-Fi
Get-WinEvent -ListLog *Network*, *NDIS*       -> daftar log jaringan
```
