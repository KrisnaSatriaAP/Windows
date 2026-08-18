# Tutorial: Mengecek Lisensi Windows Bawaan Pabrik (OEM)

Laptop atau PC yang dibeli dengan kondisi *pre-installed* Windows (sudah terinstal dari pabrik) biasanya memiliki kunci produk (Product Key) yang ditanam secara permanen di dalam *motherboard* (BIOS/UEFI).

Jika Anda ingin menginstal ulang Windows atau menghapus lisensi bajakan yang tidak sengaja terpasang, Anda bisa memanggil kode original bawaan ini.

## Cara 1: Menggunakan Command Prompt (CMD)

1. Buka **Start Menu**, lalu ketik `cmd`.
2. Klik kanan pada **Command Prompt** dan pilih **Run as administrator**.
3. Ketik (atau salin dan tempel) perintah di bawah ini, lalu tekan **Enter**:
   ```cmd
   wmic path softwarelicensingservice get OA3xOriginalProductKey
   ```

## Cara 2: Menggunakan Windows PowerShell
Jika cara pertama tidak memunculkan hasil, Anda bisa menggunakan PowerShell.

1. Buka **Start Menu**, lalu ketik `powershell`.
2. Klik kanan pada **Windows PowerShell** dan pilih **Run as administrator**.
3. Ketik (atau salin dan tempel) perintah di bawah ini, lalu tekan **Enter**:
   ```powershell
   (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey
   ```

---

## Cara Membaca Hasil

- **Jika Muncul 25 Digit Kode:**
  Anda akan melihat kombinasi 25 huruf dan angka (misalnya: `XXXXX-XXXXX-XXXXX-XXXXX-XXXXX`). Ini adalah lisensi original bawaan laptop Anda. Anda bisa memasukkannya di menu *Settings > Activation* untuk mengembalikan Windows menjadi original.

- **Jika Hasilnya Kosong (Blank):**
  Jika kursor hanya pindah ke baris baru dan tidak ada kode yang muncul, ini berarti perangkat Anda saat dibeli tidak memiliki lisensi Windows bawaan pabrik (biasanya versi DOS atau Linux), atau *motherboard* perangkat tersebut telah diganti.
