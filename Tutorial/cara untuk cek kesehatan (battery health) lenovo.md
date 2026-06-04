# Cara Cek Battery Health Laptop ThinkPad

## Metode 1: Menggunakan Lenovo Vantage (Paling Mudah)

1. Buka aplikasi **Lenovo Vantage**.
2. Pilih menu **Device** → **Power**.
3. Lihat informasi berikut:

   * Battery Health
   * Full Charge Capacity
   * Design Capacity
   * Cycle Count

### Contoh

| Parameter            | Nilai |
| -------------------- | ----- |
| Design Capacity      | 50 Wh |
| Full Charge Capacity | 45 Wh |

Perhitungan:

```
Battery Health = (45 / 50) × 100%
               = 90%
```

---

## Metode 2: Menggunakan Battery Report Windows

### Langkah 1

Buka **Command Prompt** sebagai Administrator.

### Langkah 2

Jalankan perintah berikut:

```cmd
powercfg /batteryreport
```

### Langkah 3

Windows akan membuat file laporan:

```text
C:\Windows\System32\battery-report.html
```

atau

```text
C:\Users\<Username>\battery-report.html
```

### Langkah 4

Buka file `battery-report.html` menggunakan browser.

### Langkah 5

Cari bagian **Installed Batteries** dan perhatikan nilai:

* DESIGN CAPACITY
* FULL CHARGE CAPACITY
* CYCLE COUNT

### Menghitung Battery Health

```text
Battery Health = (Full Charge Capacity / Design Capacity) × 100%
```

Contoh:

```text
Design Capacity      : 57.000 mWh
Full Charge Capacity : 51.300 mWh

Battery Health = (51.300 / 57.000) × 100%
               = 90%
```

---

## Metode 3: Menggunakan PowerShell

Buka PowerShell dan jalankan:

```powershell
Get-WmiObject Win32_Battery
```

Metode ini hanya menampilkan informasi dasar dan tidak seakurat Battery Report atau Lenovo Vantage.

---

## Interpretasi Battery Health

| Health  | Kondisi                  |
| ------- | ------------------------ |
| 95–100% | Sangat baik              |
| 85–94%  | Baik                     |
| 75–84%  | Mulai menurun            |
| 60–74%  | Performa berkurang       |
| <60%    | Disarankan ganti baterai |

---

## Tips Memperpanjang Umur Baterai ThinkPad

1. Aktifkan **Battery Charge Threshold** di Lenovo Vantage.
2. Batasi pengisian hingga 80–85% jika laptop sering terhubung charger.
3. Hindari penggunaan pada suhu tinggi.
4. Gunakan charger asli atau berkualitas baik.
5. Jangan biarkan baterai sering habis hingga 0%.
