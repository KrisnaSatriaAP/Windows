# Catatan: Cara Cek Lisensi/Edisi Windows

## Tujuan
Panduan buat mengecek jenis lisensi, edisi (Home/Pro/Enterprise), dan status aktivasi Windows di sebuah PC/laptop.

---

## Cara Cek Lisensi/Edisi Windows

### 1. Cek edisi & status aktivasi (built-in)
- **Settings → System → About** → lihat bagian "Windows specifications" → **Edition**
- **Settings → System → Activation** → lihat status aktivasi

### 2. Cek versi Windows cepat
```
Windows + R → ketik: winver
```

### 3. Cek detail lisensi lengkap (CMD/PowerShell, tanpa admin)
```
slmgr /dlv
```
**Fungsi:** Menampilkan info detail lisensi — edisi aktif, status (Licensed/Notification), partial product key, channel aktivasi (Retail/OEM/Volume-KMS), info server KMS (jika ada), sisa masa aktivasi, dan lain-lain. Berguna buat diagnosa apakah Windows genuine atau diaktifkan pakai KMS ilegal.

### 4. Cek product key OEM tertanam di BIOS (PowerShell)
```powershell
(Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey
```
Key ini biasanya adalah key OEM asli bawaan pabrik yang ditanam di firmware/BIOS.

### 5. Tool pihak ketiga: Magical Jelly Bean Keyfinder
Membaca key dari registry/BIOS dan mencocokkan dengan database key generik (GVLK) per edisi Windows. Berguna sebagai pembanding hasil `slmgr /dlv`.

---

## Jenis-Jenis Lisensi Windows

| Jenis | Keterangan |
|---|---|
| **OEM** | Terikat ke motherboard, ter-install dari pabrik, tidak bisa dipindah ke perangkat lain |
| **Retail** | Dibeli terpisah (kotak/digital dari Microsoft Store), bisa dipindah-pindah ke PC lain |
| **Volume License (KMS)** | Biasanya dipakai perusahaan/institusi, butuh koneksi ke server KMS untuk aktivasi & perlu diperpanjang berkala |
| **Digital License** | Versi digital yang ter-link ke akun Microsoft |

---

## Hal-Hal yang Perlu Diwaspadai

- **Channel `VOLUME_KMSCLIENT`** dengan **key GVLK (generik)** di `slmgr /dlv` menandakan Windows diaktifkan lewat skema Volume License/KMS, bukan lisensi retail/OEM biasa.
- Kalau **server KMS yang terdaftar bukan milik Microsoft** (misalnya domain/IP asing yang tidak dikenal), itu indikasi aktivasi dilakukan lewat **KMS emulator/pihak ketiga** — metode ini termasuk **aktivasi ilegal/bajakan**, meskipun status yang muncul "Licensed".
- Aktivasi via KMS pihak ketiga **tidak permanen** — kalau server tersebut mati atau tidak bisa diakses, status aktivasi Windows bisa berubah jadi "not activated".
- **Product key OEM tidak bisa dipakai lintas edisi** — key yang didesain untuk Windows Home tidak akan work di Windows Pro, begitu juga sebaliknya. Kalau input key OEM gagal dengan error semacam `0x803fa067`, kemungkinan besar edisi yang sedang terinstall tidak cocok dengan key tersebut.
- Hasil cek dari beberapa tool bisa **berbeda-beda/kontradiktif** kalau sistem pernah diaktifkan pakai loader/tool bajakan — biasanya karena sisa registry/cache dari proses aktivasi sebelumnya yang tidak bersih.

---

## Langkah Kalau Ingin Windows yang Genuine

1. **Cek key OEM asli** lewat command di poin 4 di atas.
2. **Install ulang Windows** dari ISO resmi Microsoft, pilih edisi yang sesuai dengan key OEM tersebut (kalau tidak yakin edisinya apa, coba Home dulu karena mayoritas laptop consumer bawaannya Home; laptop business series kadang bawaannya Pro).
3. Masukkan key OEM saat instalasi — Windows Setup otomatis mendeteksi & memasang edisi yang sesuai.
4. Kalau ingin edisi lain (misalnya upgrade ke Pro) dan key OEM tidak cocok, beli lisensi resmi terpisah lewat Microsoft Store atau reseller resmi.
5. Verifikasi ulang lewat `slmgr /dlv` setelah instalasi bersih — pastikan channel aktivasi jelas (OEM/Retail), bukan Volume-KMS pihak ketiga.
