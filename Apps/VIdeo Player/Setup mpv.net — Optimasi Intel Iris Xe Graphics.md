# Tutorial Setup mpv.net — Optimasi Intel Iris Xe Graphics

> Panduan ini khusus untuk perangkat dengan **Intel Iris Xe Graphics** (Intel Gen 11+),
> termasuk ThinkPad T14 Gen 2, Dell XPS 13, dan laptop Intel Core generasi 11/12/13.

---

## Daftar Isi

1. [Persyaratan](#persyaratan)
2. [Install mpv.net](#install-mpvnet)
3. [Konfigurasi mpv.conf](#konfigurasi-mpvconf)
4. [Setup YouTube Streaming](#setup-youtube-streaming)
5. [Verifikasi Hardware Decode](#verifikasi-hardware-decode)
6. [Shortcut Penting](#shortcut-penting)
7. [Troubleshooting](#troubleshooting)

---

## Persyaratan

| Komponen | Keterangan |
|---|---|
| OS | Windows 10/11 64-bit |
| GPU | Intel Iris Xe (Gen 11+) |
| .NET Runtime | .NET 10 LTS (wajib untuk mpv.net) |
| Internet | Untuk download & YouTube streaming |

---

## Install mpv.net

### Step 1 — Install .NET 10 LTS

Download dari: https://dotnet.microsoft.com/en-us/download/dotnet/10.0

Pilih **.NET Desktop Runtime 10.0** → **Windows x64** → install.

### Step 2 — Download mpv.net

Download dari: https://github.com/mpvnet-player/mpv.net/releases/latest

Pilih file **`mpv.net-setup.exe`** → install next → next → finish.

---

## Konfigurasi mpv.conf

### Cara buka mpv.conf

Pilih salah satu cara:

**Opsi A — Lewat aplikasi mpv.net (lebih mudah)**
```
Config → Edit mpv.conf
```
File langsung terbuka di Notepad.

**Opsi B — Lewat File Explorer**

buka manual di File Explorer, paste path ini di address bar:
```
%APPDATA%\mpv.net\
```
Cari file `mpv.conf` → klik kanan → **Open with Notepad**.

---

Isi dengan konfigurasi berikut:

```ini
# ============================================================
# mpv.conf — Optimized for Intel Iris Xe Graphics
# ============================================================

# ----- VIDEO OUTPUT -----
vo=gpu-next
gpu-api=d3d11
d3d11-sync-interval=1

# ----- UPSCALING (balance kualitas vs performa iGPU) -----
scale=spline36
dscale=mitchell
cscale=spline36

# ----- HDR TONE MAPPING -----
tone-mapping=bt.2446a
target-colorspace-hint=yes
hdr-compute-peak=yes

# ----- HARDWARE DECODE -----
# auto-safe = otomatis pilih decoder terbaik yang didukung hardware
hwdec=auto-safe
hwdec-codecs=all

# ----- AUDIO -----
audio-channels=stereo
volume=100
volume-max=130

# ----- SUBTITLE -----
sub-auto=fuzzy
sub-font=Arial
sub-font-size=42
sub-blur=0.2
sub-border-size=2.5

# ----- CACHE -----
cache=yes
demuxer-max-bytes=100MiB
demuxer-readahead-secs=10

# ----- MISC -----
keep-open=yes
save-position-on-quit=yes
autofit=85%
```

> **Catatan:** Jangan tambahkan `osc=no` atau `border=no` karena akan menghilangkan UI mpv.net.

Setelah selesai edit → **Save** → **restart mpv.net**.

---

## Setup YouTube Streaming

mpv.net bisa stream YouTube langsung tanpa browser, tanpa iklan.

### Step 1 — Download yt-dlp

Download **`yt-dlp.exe`** dari: https://github.com/yt-dlp/yt-dlp/releases/latest

Taruh file `yt-dlp.exe` di folder:
```
C:\mpv\
```
Atau di folder manapun yang sudah ada di PATH Windows.

### Step 2 — Tambah config YouTube di mpv.conf

Buka **Config → Edit mpv.conf**, tambahkan baris berikut:

```ini
# ----- YOUTUBE / STREAMING -----
# VP9 1080p diprioritaskan karena Iris Xe support hardware decode VP9
# AV1 4K tidak disarankan karena Iris Xe tidak punya hardware AV1 decoder
ytdl-format=bestvideo[vcodec^=vp9][height<=1080]+bestaudio/bestvideo[height<=1080]+bestaudio/best
```

### Step 3 — Cara pakai

1. Copy URL YouTube
2. Di mpv.net: **Menu → Open → Open URL**
3. Paste URL → Enter
4. Video langsung stream tanpa iklan

---

## Verifikasi Hardware Decode

Saat video sedang diputar, buka console dengan menekan tombol:

```
` (backtick/tilde — tombol kiri angka 1)
```

Ketik perintah berikut di console:

```
print-text ${hwdec-current}
```

**Hasil yang diharapkan:**

| Output | Status |
|---|---|
| `d3d11va` | ✅ Hardware decode aktif |
| `d3d11va-copy` | ✅ Hardware decode aktif |
| `no` atau kosong | ❌ Software decode — cek config |

### Cek via Task Manager

Buka Task Manager (`Ctrl+Shift+Esc`) → tab **Performance** → klik **GPU 0**:

| Kondisi | Keterangan |
|---|---|
| **3D** ada angkanya | GPU render engine aktif (normal untuk mpv) |
| GPU total **< 50%** saat 1080p | Efisien ✅ |
| GPU total **100%** terus | Kemungkinan AV1 4K tanpa HW decoder |

---

## Shortcut Penting

| Tombol | Fungsi |
|---|---|
| `Space` | Play / Pause |
| `F` | Fullscreen |
| `←` / `→` | Skip 5 detik |
| `↑` / `↓` | Volume naik/turun |
| `[` / `]` | Lambat / cepat playback speed |
| `\` | Reset playback speed |
| `S` | Screenshot |
| `Z` / `X` | Geser timing subtitle |
| `R` / `T` | Perbesar / perkecil subtitle |
| `L` (2x) | A-B loop repeat |
| `` ` `` | Buka console |
| `i` | Info file |

---

## Troubleshooting

### hwdec tetap `no` setelah config

Pastikan baris berikut ada di `mpv.conf` (**Config → Edit mpv.conf**):
```ini
hwdec=auto-safe
hwdec-codecs=all
```
Kemudian restart mpv.net dan buka video baru.

---

### GPU 100% saat streaming YouTube

Penyebab: YouTube mengirim format **AV1** yang tidak punya hardware decoder di Iris Xe.

Fix: pastikan config ytdl-format sudah diset ke VP9:
```ini
ytdl-format=bestvideo[vcodec^=vp9][height<=1080]+bestaudio/bestvideo[height<=1080]+bestaudio/best
```

---

### Video artifact / glitch

Ganti `gpu-api` di `mpv.conf`:
```ini
# Coba urutan ini satu per satu:
gpu-api=d3d11    # default, paling stabil
gpu-api=auto     # fallback
```

---

### Subtitle tidak muncul

Pastikan baris ini ada di `mpv.conf`:
```ini
sub-auto=fuzzy
```
`fuzzy` artinya mpv akan otomatis cari file subtitle dengan nama mirip file video.

---

### Font subtitle tidak sesuai (fallback ke Arial)

File subtitle ASS/SSA kadang pakai font custom yang tidak ada di Windows.
Download font yang dibutuhkan dan install di Windows:
klik kanan file font → **Install for all users**.

---

*Dibuat berdasarkan pengujian langsung di ThinkPad T14 Gen 2 (Intel Core i7 Gen 11, Iris Xe Graphics)*
