# Tutorial: Mengecek Kesehatan Baterai Laptop Windows

Seiring berjalannya waktu dan penggunaan, performa baterai laptop pasti akan menurun. Windows menyediakan fitur tersembunyi yang sangat berguna untuk menghasilkan laporan detail mengenai kesehatan dan riwayat penggunaan baterai Anda.

Berikut adalah langkah-langkah untuk membuat dan membaca *Battery Report* (Laporan Baterai) di Windows.

## Langkah-langkah Mengecek Kesehatan Baterai

### 1. Buka Command Prompt sebagai Administrator
1. Klik menu **Start** pada Windows.
2. Ketik `cmd` pada kolom pencarian.
3. Pada hasil pencarian **Command Prompt**, klik kanan lalu pilih **Run as administrator**.
4. Jika muncul jendela peringatan *User Account Control*, klik **Yes**.

### 2. Jalankan Perintah Laporan Baterai
1. Di dalam jendela Command Prompt yang berwarna hitam, ketik perintah berikut (atau *copy-paste*):
   ```cmd
   powercfg /batteryreport
   ```
2. Tekan tombol **Enter**.
3. Jika berhasil, akan muncul pesan seperti:
   `Battery life report saved to file path C:\Windows\System32\battery-report.html` 
   *(Catatan: Lokasi penyimpanan file mungkin berbeda, misalnya di `C:\Users\[NamaUser]\battery-report.html`)*

### 3. Buka File Laporan
1. Buka **File Explorer** (tekan tombol `Windows + E`).
2. Arahkan ke *folder* atau lokasi tempat file tersebut disimpan sesuai pesan di CMD tadi.
3. Cari file bernama `battery-report.html`.
4. Klik dua kali pada file tersebut. File ini akan terbuka melalui *web browser* (seperti Google Chrome atau Microsoft Edge).

---

## Cara Membaca Battery Report

Setelah laporan terbuka, Anda akan melihat banyak sekali data. Untuk mengetahui kesehatan baterai, fokuslah pada bagian **Installed batteries**. 

Perhatikan dua angka penting ini:

1. **Design Capacity:**
   Ini adalah kapasitas maksimal baterai saat masih baru keluar dari pabrik (biasanya dalam satuan mWh).
   
2. **Full Charge Capacity:**
   Ini adalah kapasitas maksimal yang bisa ditampung baterai pada saat ini. 

### Analisis Kesehatan:
- **Baterai Sehat:** Jika angka *Full Charge Capacity* masih sama atau hanya turun sedikit dibandingkan *Design Capacity* (misalnya dari 45,000 mWh menjadi 42,000 mWh).
- **Baterai Mulai Menurun (Drop):** Jika selisih antara *Design Capacity* dan *Full Charge Capacity* sudah sangat jauh (misalnya kapasitas pabrik 45,000 mWh, tapi saat ini hanya bisa menampung 20,000 mWh). Jika ini terjadi, laptop Anda pasti akan terasa lebih cepat habis baterainya dan mungkin sudah saatnya mempertimbangkan untuk mengganti baterai.

## (Khusus Pengguna Lenovo) Menggunakan Lenovo Vantage
Jika Anda menggunakan laptop Lenovo (seperti ThinkPad atau IdeaPad), ada cara yang lebih mudah tanpa perlu menggunakan CMD:

1. Buka aplikasi **Lenovo Vantage** dari Start Menu.
2. Navigasi ke menu **Device** > **Power**.
3. Klik tombol **Battery Details**.
4. Di sana akan langsung terlihat status *Condition* (Good/Fair/Poor), jumlah *Cycle Count* (seberapa sering baterai dicas penuh), serta perbandingan kapasitasnya.
