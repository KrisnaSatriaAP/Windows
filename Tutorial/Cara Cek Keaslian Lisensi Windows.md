# Tutorial: Mengecek Keaslian Lisensi Windows

Mengetahui status lisensi Windows Anda sangat penting untuk memastikan keamanan sistem. Berikut adalah cara untuk mengecek apakah Windows Anda original atau menggunakan lisensi bajakan.

## 1. Mengecek Masa Berlaku Melalui Command Prompt (Akurat)
Windows original memiliki lisensi seumur hidup (permanen), sedangkan Windows bajakan umumnya memiliki masa berlaku yang harus diperbarui berkala.

1. Buka **Start Menu** dan ketik `cmd`.
2. Klik kanan pada **Command Prompt** dan pilih **Run as administrator**.
3. Ketik perintah berikut dan tekan **Enter**:
   ```cmd
   slmgr /xpr
   ```
4. **Hasilnya:**
   - **Original:** Muncul pesan *"The machine is permanently activated"*.
   - **Bajakan:** Muncul pesan tanggal kedaluwarsa, seperti *"Volume activation will expire on..."*.

## 2. Mengecek Jenis Lisensi (Channel)
Anda juga perlu memastikan jenis lisensi yang terpasang sesuai dengan perangkat Anda.

1. Buka **Command Prompt** (Run as administrator).
2. Ketik perintah berikut dan tekan **Enter**:
   ```cmd
   slmgr /dli
   ```
3. **Hasilnya:** Perhatikan baris **Description**:
   - **RETAIL / OEM channel:** Original (untuk penggunaan personal).
   - **VOLUME_KMSCLIENT channel:** Lisensi perusahaan. Jika ini komputer pribadi, maka **dipastikan bajakan**.

## 3. Mengecek Melalui Pengaturan Windows
Ini adalah cara cepat, meski tidak sedetail CMD.

1. Tekan tombol `Windows + I` untuk membuka **Settings**.
2. Buka menu aktivasi:
   - **Windows 10:** Pilih **Update & Security** > **Activation**.
   - **Windows 11:** Pilih **System** > **Activation**.
3. Jika statusnya *Active* dan terhubung ke akun Microsoft Anda, ini pertanda baik. Jika ada tulisan *"Activated using your organization's activation service"*, kemungkinan bajakan.
