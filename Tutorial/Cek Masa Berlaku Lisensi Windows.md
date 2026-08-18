# Mengecek Masa Berlaku Melalui Command Prompt (Akurat)
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
