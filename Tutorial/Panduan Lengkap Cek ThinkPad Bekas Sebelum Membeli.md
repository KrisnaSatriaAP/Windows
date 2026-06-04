# Panduan Lengkap Cek ThinkPad Bekas Sebelum Membeli

## Tujuan

Panduan ini membantu memastikan laptop ThinkPad bekas dalam kondisi baik, bebas password BIOS, tidak bermasalah pada hardware, dan layak dibeli.

---

# 1. Cek Spesifikasi Dasar

## Cara

Tekan:

```cmd
Windows + R
```

Ketik:

```cmd
msinfo32
```

Periksa:

* Model laptop
* Processor
* RAM
* Versi BIOS

Atau buka CMD:

```cmd
systeminfo
```

Pastikan spesifikasi sesuai dengan iklan penjual.

---

# 2. Cek Password BIOS (WAJIB)

## Cara Masuk BIOS

1. Matikan laptop.
2. Nyalakan.
3. Tekan tombol **F1** berulang kali.

## Yang Harus Dicek

Masuk ke menu BIOS.

Coba ubah:

* Boot Order
* Virtualization
* Security

Jika muncul permintaan password administrator atau supervisor password:

```text
Enter Supervisor Password
```

Sebaiknya batalkan pembelian.

Password BIOS pada ThinkPad dapat menyulitkan upgrade dan konfigurasi.

---

# 3. Cek Kesehatan Baterai

## Cara

Buka Command Prompt sebagai Administrator.

Jalankan:

```cmd
powercfg /batteryreport
```

Buka file:

```text
C:\Users\<Username>\battery-report.html
```

Cari bagian:

```text
DESIGN CAPACITY
FULL CHARGE CAPACITY
CYCLE COUNT
```

## Menghitung Battery Health

```text
Battery Health =
(Full Charge Capacity / Design Capacity) x 100%
```

### Interpretasi

| Health  | Kondisi                     |
| ------- | --------------------------- |
| 95-100% | Sangat Baik                 |
| 85-94%  | Baik                        |
| 75-84%  | Masih Layak                 |
| <75%    | Pertimbangkan Ganti Baterai |

---

# 4. Cek SSD

## Cara Cepat

Buka CMD:

```cmd
wmic diskdrive get model,status
```

Hasil ideal:

```text
OK
```

## Cara Lengkap

Install CrystalDiskInfo.

Periksa:

* Health Status
* Power On Hours
* Total Host Writes

### Interpretasi

| Health  | Kondisi       |
| ------- | ------------- |
| 90-100% | Sangat Baik   |
| 80-89%  | Baik          |
| <80%    | Mulai Menurun |

---

# 5. Cek RAM

Tekan:

```cmd
Ctrl + Shift + Esc
```

Masuk:

```text
Performance → Memory
```

Periksa:

* Total RAM
* Kecepatan RAM
* Slot yang digunakan

Pastikan sesuai iklan.

---

# 6. Cek LCD

## Dead Pixel Test

Buka browser:

```text
https://lcdtech.info/en/tests/dead.pixel.htm
```

Tampilkan warna:

* Merah
* Hijau
* Biru
* Putih
* Hitam

Periksa apakah ada titik yang tidak berubah warna.

---

# 7. Cek Keyboard

Buka:

```text
https://keyboard-test.space/
```

Tekan semua tombol.

Pastikan:

* Semua huruf berfungsi
* Tombol Function (F1-F12) normal
* Tombol Fn normal

---

# 8. Cek Touchpad dan TrackPoint

## Touchpad

Geser kursor.

Coba:

* Klik kiri
* Klik kanan
* Scroll dua jari

## TrackPoint

Gerakkan pointer menggunakan tombol merah di tengah keyboard.

Pastikan tidak drifting atau bergerak sendiri.

---

# 9. Cek Speaker

Buka YouTube.

Putar video.

Periksa:

* Suara kiri dan kanan keluar
* Tidak pecah
* Tidak kresek

---

# 10. Cek Kamera

Buka:

```text
Camera
```

Periksa:

* Gambar normal
* Tidak buram
* Tidak gelap

---

# 11. Cek Mikrofon

Buka:

```text
Voice Recorder
```

Rekam suara.

Putar ulang hasil rekaman.

---

# 12. Cek Wi-Fi

Hubungkan ke hotspot HP.

Pastikan:

* Bisa connect
* Tidak putus-putus
* Kecepatan normal

---

# 13. Cek Bluetooth

Pasangkan dengan:

* HP
* Earphone
* Speaker Bluetooth

Pastikan perangkat terdeteksi.

---

# 14. Cek Port USB

Siapkan flashdisk.

Tes seluruh port:

* USB-A
* USB-C

Pastikan terbaca.

---

# 15. Cek HDMI

Hubungkan monitor atau TV.

Tekan:

```cmd
Windows + P
```

Pilih:

```text
Duplicate
```

Pastikan gambar muncul.

---

# 16. Cek LAN

Hubungkan kabel jaringan.

Buka CMD:

```cmd
ping 8.8.8.8 -t
```

Pastikan tidak ada packet loss.

---

# 17. Cek Charger

Periksa label adaptor.

Untuk ThinkPad T14 Gen 2:

* Minimal 45W
* Disarankan 65W Original Lenovo

Pastikan laptop dapat mengisi daya tanpa putus-putus.

---

# 18. Cek Temperatur

Install HWiNFO64.

Periksa suhu saat idle.

### Normal

| Kondisi    | Suhu    |
| ---------- | ------- |
| Idle       | 40-60°C |
| Browsing   | 50-75°C |
| Load Berat | 70-90°C |

Jika idle di atas 70°C, perlu dicurigai.

---

# 19. Cek Kondisi Fisik

Periksa:

* Retak bodi
* Bekas jatuh
* Baut hilang
* Bekas cairan
* Engsel longgar

Buka tutup layar beberapa kali.

Engsel harus terasa kokoh.

---

# 20. Cek Garansi Lenovo

Masukkan Serial Number ke:

https://pcsupport.lenovo.com/warrantylookup

Pastikan:

* Serial Number valid
* Model sesuai
* Tidak ada indikasi penggantian motherboard ilegal

---

# Kesimpulan Cepat

Minimal lulus poin berikut:

✅ BIOS tidak terkunci
✅ SSD sehat >90%
✅ Battery Health >80%
✅ Tidak ada dead pixel
✅ Keyboard normal
✅ Semua port berfungsi
✅ Wi-Fi dan Bluetooth normal
✅ Suhu idle <60°C
✅ Engsel kokoh
✅ Charger original

Jika semua poin di atas lolos, ThinkPad bekas biasanya aman untuk dibeli.
