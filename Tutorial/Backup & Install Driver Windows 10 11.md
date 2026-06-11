# Tutorial Backup & Install Driver Windows

> **Platform:** Windows 10 / 11  
> **Tools:** `pnputil`, `dism` (built-in Windows)  

---

## Daftar Isi

1. [Persiapan](#1-persiapan)
2. [Backup Driver](#2-backup-driver)
   - [Metode A — pnputil](#metode-a--pnputil-direkomendasikan)
   - [Metode B — DISM](#metode-b--dism)
3. [Install Driver dari Backup](#3-install-driver-dari-backup)
   - [Install via pnputil](#install-via-pnputil)
   - [Install via DISM](#install-via-dism)
   - [Install via Device Manager (GUI)](#install-via-device-manager-gui)
4. [Perbandingan pnputil vs DISM](#4-perbandingan-pnputil-vs-dism)
5. [Troubleshooting](#5-troubleshooting)

---

## 1. Persiapan

Sebelum mulai, pastikan:

- Login sebagai **Administrator** atau akun dengan hak admin
- Siapkan folder tujuan backup, contoh: `C:\DriverBackup`
- Buka **Command Prompt** atau **PowerShell** sebagai Administrator

### Cara buka CMD sebagai Administrator

1. Tekan `Win + S`, ketik **cmd**
2. Klik kanan → **Run as administrator**
3. Klik **Yes** pada dialog UAC

---

## 2. Backup Driver

### Metode A — pnputil (Direkomendasikan)

Cocok untuk backup cepat pada laptop/PC yang sedang dipakai.

**Backup semua driver:**

```cmd
pnputil /export-driver * C:\DriverBackup
```

**Penjelasan parameter:**

| Parameter | Keterangan |
|---|---|
| `*` | Export semua driver yang terinstall |
| `C:\DriverBackup` | Folder tujuan backup |

**Contoh output:**

```
Microsoft PnP Utility

Exporting driver package: oem0.inf
Exporting driver package: oem1.inf
...
Total exported: 45
```

> ✅ Setelah selesai, folder `C:\DriverBackup` berisi subfolder per driver dalam format `.inf` beserta file pendukungnya.

---

### Metode B — DISM

Cocok untuk keperluan deploy image Windows ke banyak PC.

**Backup semua driver:**

```cmd
dism /online /export-driver /destination:C:\DriverBackup
```

**Penjelasan parameter:**

| Parameter | Keterangan |
|---|---|
| `/online` | Bekerja pada Windows yang sedang aktif |
| `/export-driver` | Perintah export driver |
| `/destination` | Folder tujuan backup |

> ✅ Hasilnya sama-sama format `.inf`, bisa diinstall ulang menggunakan `pnputil` maupun `dism`.

---

### Simpan Hasil Backup

Setelah backup selesai, **copy folder** `C:\DriverBackup` ke media penyimpanan eksternal:

```
C:\DriverBackup\  →  FlashDisk / HDD Eksternal / Google Drive
```

---

## 3. Install Driver dari Backup

### Install via pnputil

Cara paling praktis, bisa dipakai dari hasil backup `pnputil` maupun `dism`.

**Install semua driver sekaligus:**

```cmd
pnputil /add-driver C:\DriverBackup\*.inf /subdirs /install
```

**Install satu driver spesifik:**

```cmd
pnputil /add-driver C:\DriverBackup\namadriver.inf /install
```

**Penjelasan parameter:**

| Parameter | Keterangan |
|---|---|
| `/add-driver` | Perintah install driver |
| `*.inf` | Semua file driver |
| `/subdirs` | Masuk ke subfolder secara otomatis |
| `/install` | Langsung install, bukan hanya daftarkan |

---

### Install via DISM

Bisa digunakan untuk Windows yang sedang aktif atau image offline.

**Windows aktif:**

```cmd
dism /online /add-driver /driver:C:\DriverBackup /recurse
```

**Image Windows offline (mis. saat setup):**

```cmd
dism /image:D:\MountedImage /add-driver /driver:C:\DriverBackup /recurse
```

**Penjelasan parameter:**

| Parameter | Keterangan |
|---|---|
| `/online` | Target Windows yang sedang berjalan |
| `/add-driver` | Perintah install driver |
| `/driver` | Path folder backup |
| `/recurse` | Masuk subfolder otomatis |

---

### Install via Device Manager (GUI)

Gunakan cara ini jika ada driver tertentu yang gagal lewat command line.

1. Tekan `Win + X` → pilih **Device Manager**
2. Cari device dengan tanda **⚠️ (tanda seru kuning)**
3. Klik kanan → **Update driver**
4. Pilih **Browse my computer for drivers**
5. Klik **Browse**, arahkan ke folder `C:\DriverBackup`
6. Centang **Include subfolders**
7. Klik **Next** dan ikuti proses instalasi
8. **Restart** PC setelah selesai

---

## 4. Perbandingan pnputil vs DISM

| Aspek | `pnputil` | `dism` |
|---|---|---|
| Fungsi utama | Manajemen driver di driver store | Manajemen image/sistem Windows |
| Kecepatan | ✅ Lebih cepat | Sedikit lebih lambat |
| Install ke Windows aktif | ✅ Bisa | ✅ Bisa |
| Install ke image offline | ❌ Tidak bisa | ✅ Bisa |
| Cocok untuk | Backup harian, laptop pribadi | Deploy image, enterprise |
| Tingkat kesulitan | ✅ Mudah | Sedang |

**Rekomendasi:**
- Laptop/PC pribadi → gunakan **pnputil**
- Deploy ke banyak PC / reinstall massal → gunakan **dism**

---

## 5. Troubleshooting

### Driver gagal diinstall

```
Error: The specified driver package was not accepted.
```

**Solusi:**
- Pastikan CMD dijalankan sebagai Administrator
- Coba install driver satu per satu untuk cari yang bermasalah
- Cek apakah driver sudah versi terbaru (normal jika di-skip)

---

### Driver ter-skip / tidak diinstall

Biasanya muncul pesan:

```
Driver package already installed or newer version exists.
```

**Ini normal.** Artinya driver sudah ada dan versi yang terinstall lebih baru dari backup.

---

### Device masih tidak terdeteksi setelah install

1. **Restart** PC terlebih dahulu
2. Buka Device Manager, cek apakah masih ada tanda ⚠️
3. Jika masih bermasalah, download driver terbaru langsung dari website produsen (Intel, Realtek, dll.)

---

### Folder backup kosong / tidak ada hasil

Pastikan:
- CMD dijalankan sebagai **Administrator**
- Folder tujuan sudah ada atau buat dulu secara manual:

```cmd
mkdir C:\DriverBackup
```

---

## Referensi Cepat

```cmd
# Backup semua driver (pnputil)
pnputil /export-driver * C:\DriverBackup

# Backup semua driver (dism)
dism /online /export-driver /destination:C:\DriverBackup

# Install semua driver dari backup
pnputil /add-driver C:\DriverBackup\*.inf /subdirs /install

# Install via dism (Windows aktif)
dism /online /add-driver /driver:C:\DriverBackup /recurse
```

---

*Tutorial ini berlaku untuk Windows 10 dan Windows 11.*
