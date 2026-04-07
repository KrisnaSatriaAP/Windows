# 🦠 Flashdisk Shortcut Virus Fix Guide

Panduan lengkap untuk mengembalikan file flashdisk yang berubah menjadi
shortcut akibat virus.

Virus shortcut biasanya **tidak menghapus file**, hanya
menyembunyikannya.

Dokumentasi ini cocok digunakan untuk:

-   teknisi sekolah
-   admin lab komputer
-   operator jaringan
-   pengguna Windows umum

------------------------------------------------------------------------

# 📌 Gejala Flashdisk Terkena Virus Shortcut

Ciri-ciri umum:

-   file berubah menjadi shortcut (.lnk)
-   folder asli tidak terlihat
-   flashdisk terlihat kosong
-   kapasitas flashdisk masih terpakai
-   muncul file seperti:

```{=html}
<!-- -->
```
    autorun.inf
    *.lnk
    *.vbs

------------------------------------------------------------------------

# 🚀 Cara Cepat (Menggunakan Script Otomatis)

## Langkah 1

Buka Notepad

## Langkah 2

Copy script berikut:

    @echo off
    echo =====================================
    echo   FLASHDISK SHORTCUT VIRUS FIX TOOL
    echo =====================================
    echo.
    echo Processing...
    attrib -s -h -r /s /d *.*
    echo.
    echo Done!
    echo Hidden files restored successfully.
    echo.
    pause

## Langkah 3

Save dengan nama:

    fix-shortcut.bat

## Langkah 4

Copy file tersebut ke flashdisk

## Langkah 5

Double click:

    fix-shortcut.bat

Tunggu proses selesai.

File akan muncul kembali.

------------------------------------------------------------------------

# 🔧 Cara Manual Menggunakan CMD

Jika ingin manual:

Tekan:

    Windows + R

Ketik:

    cmd

Masuk ke drive flashdisk (contoh):

    E:

Jalankan perintah:

    attrib -s -h -r /s /d *.*

Tunggu proses selesai.

File biasanya langsung kembali muncul.

------------------------------------------------------------------------

# 🧹 Setelah Recovery

Hapus file berikut jika masih ada:

    autorun.inf
    *.lnk
    *.vbs

⚠️ Jangan hapus folder asli pengguna.

------------------------------------------------------------------------

# 🛡️ Disarankan Scan Antivirus

Gunakan:

-   Windows Defender
-   Smadav
-   Malwarebytes

Untuk memastikan virus tidak muncul kembali.

------------------------------------------------------------------------

# 🧪 Troubleshooting Jika File Masih Tidak Muncul

Aktifkan hidden file:

    File Explorer → View → Show → Hidden items

Kemudian jalankan ulang:

    attrib -h -r -s /s /d *.*

------------------------------------------------------------------------

# ✅ Pencegahan Agar Tidak Terinfeksi Lagi

Disarankan:

-   hindari komputer publik
-   scan flashdisk sebelum dibuka
-   nonaktifkan autorun Windows
-   gunakan antivirus aktif realtime
-   backup file penting secara rutin

------------------------------------------------------------------------

# 👨‍💻 Catatan Teknisi

Virus shortcut paling sering berasal dari:

-   komputer sekolah
-   komputer warnet
-   komputer kantor tanpa antivirus aktif

Selalu scan flashdisk sebelum digunakan di banyak perangkat.
