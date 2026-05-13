# 🖥️ Mempertajam Teks di Windows 11

> Tutorial mengatasi teks yang terlihat abu-abu / kurang hitam pada aplikasi lama (Win32) seperti WinBox, PuTTY, dll di Windows 11.

![OS](https://img.shields.io/badge/OS-Windows%2011-blue?logo=windows)
![Status](https://img.shields.io/badge/status-tested-brightgreen)
![Type](https://img.shields.io/badge/type-registry%20%7C%20settings-orange)

---

## 📋 Daftar Isi
- [Penyebab](#-penyebab)
- [Solusi 1 — ClearType Text Tuner](#-solusi-1--cleartype-text-tuner)
- [Solusi 2 — DPI Override per Aplikasi](#-solusi-2--dpi-override-per-aplikasi)
- [Solusi 3 — Accessibility Text Size](#-solusi-3--accessibility-text-size)
- [Solusi 4 — Kalibrasi Monitor](#-solusi-4--kalibrasi-monitor)
- [Perbandingan Solusi](#-perbandingan-solusi)

---

## ⚠️ Penyebab

Aplikasi berbasis **Win32 lama** (WinBox, PuTTY, dll) sering menampilkan teks yang terlihat tipis atau abu-abu di Windows 11 karena:

- Font rendering yang tidak optimal di layar HiDPI / scaling tinggi
- Pengaturan ClearType yang belum dikalibrasi
- Konflik antara DPI aplikasi dan DPI sistem Windows

---

## ✅ Solusi 1 — ClearType Text Tuner

> 💡 **Rekomendasi utama** — paling efektif untuk semua aplikasi sekaligus.

### Langkah-langkah

1. Tekan **`Win + R`** → ketik perintah berikut → tekan **Enter**

   ```
   cttune
   ```

2. Centang **"Turn on ClearType"**

3. Klik **Next** dan ikuti wizard

4. Pada setiap langkah, **pilih teks yang terlihat paling tajam dan gelap** menurutmu

5. Klik **Finish**

6. **Restart** aplikasi yang bermasalah

---

## ✅ Solusi 2 — DPI Override per Aplikasi

> 💡 Khusus untuk satu aplikasi tertentu (misalnya WinBox saja).

### Langkah-langkah

1. Klik kanan shortcut atau file `.exe` aplikasi → pilih **Properties**

2. Buka tab **Compatibility**

3. Klik tombol **"Change high DPI settings"**

4. Centang **"Override high DPI scaling behavior"**

5. Pada dropdown **"Scaling performed by:"** pilih → **`Application`**

6. Klik **OK** → **OK**

7. **Restart** aplikasinya

---

## ✅ Solusi 3 — Accessibility Text Size

> 💡 Efek global ke seluruh Windows, teks jadi lebih tebal dan gelap.

### Cara A — Perbesar Ukuran Teks

```
Settings → Accessibility → Text size
```
Geser slider ke ukuran yang lebih besar → klik **Apply**

### Cara B — Contrast Theme

```
Settings → Accessibility → Contrast themes
```
Pilih salah satu tema berikut:

| Tema | Keterangan |
|------|-----------|
| **Aquatic** | Teks gelap, latar terang |
| **Dusk** | Teks terang, latar gelap |
| **Desert** | Kontras tinggi, cocok untuk siang |
| **Night sky** | Mode gelap penuh |

---

## ✅ Solusi 4 — Kalibrasi Monitor

> 💡 Jika masalah bukan dari software tapi dari setting monitor.

### Langkah-langkah

```
Settings → System → Display → Calibrate display color
```

Pastikan:
- **Gamma** — tidak terlalu rendah (teks jadi pucat) atau terlalu tinggi
- **Contrast** — sesuaikan agar teks terlihat solid/gelap
- **Brightness** — jangan terlalu terang

---

## 📊 Perbandingan Solusi

| Solusi | Efek | Berlaku Untuk | Kesulitan |
|--------|------|--------------|-----------|
| ClearType Tuner | Font rendering global | Semua aplikasi | ⭐ Mudah |
| DPI Override | Scaling per app | 1 aplikasi saja | ⭐ Mudah |
| Accessibility Text | Ukuran & ketebalan font | Semua aplikasi | ⭐ Mudah |
| Kalibrasi Monitor | Gamma & kontras layar | Semua tampilan | ⭐⭐ Sedang |

---

## 🔁 Urutan yang Disarankan

```
1. Coba Solusi 1 (ClearType) dulu
         ↓ masih kurang?
2. Coba Solusi 2 (DPI Override) untuk app bermasalah
         ↓ masih kurang?
3. Coba Solusi 3 (Text Size / Contrast Theme)
         ↓ masih kurang?
4. Kalibrasi monitor
```

---

## 🖥️ Aplikasi yang Sering Bermasalah

- [x] MikroTik **WinBox**
- [x] **PuTTY**
- [x] **WinSCP**
- [x] Aplikasi lawas berbasis **Win32 / MFC**

---
