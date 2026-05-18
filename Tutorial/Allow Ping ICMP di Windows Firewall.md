# 🖥️ Allow Ping (ICMP) di Windows Firewall

Tutorial ini menjelaskan cara mengizinkan ping (ICMP) masuk ke komputer Windows yang sebelumnya diblokir oleh Windows Firewall.

---

## 📌 Latar Belakang

Secara default, Windows Firewall **memblokir request ping (ICMP Echo)** dari perangkat lain di jaringan. Hal ini menyebabkan perangkat seperti router MikroTik tidak bisa melakukan ping ke komputer Windows meskipun koneksi jaringan sudah terhubung dengan benar.

**Gejala yang umum terjadi:**
- Router/MikroTik tidak bisa ping ke PC Windows
- PC bisa ping ke router, tapi tidak sebaliknya
- Koneksi internet di PC tetap berjalan normal

---

## ✅ Solusi

### Cara 1 — Via CMD (Cepat & Direkomendasikan)

1. Buka **Command Prompt sebagai Administrator**
   - Tekan `Win + S` → ketik `cmd`
   - Klik kanan → **Run as administrator**

2. Jalankan perintah berikut:

```cmd
netsh advfirewall firewall add rule name="Allow ICMPv4" protocol=icmpv4:8,any dir=in action=allow
```

3. Jika berhasil, akan muncul pesan:
```
Ok.
```

---

### Cara 2 — Via Windows Defender Firewall (GUI)

1. Buka **Windows Security**
2. Pilih **Firewall & network protection**
3. Klik **Advanced settings**
4. Pilih **Inbound Rules** → klik **New Rule**
5. Ikuti langkah berikut:

| Langkah | Pilihan |
|---------|---------|
| Rule Type | Custom |
| Program | All programs |
| Protocol | ICMPv4 |
| ICMP Settings | Specific → Echo Request |
| Scope | Any IP address |
| Action | Allow the connection |
| Profile | Domain, Private, Public (centang semua) |
| Name | `Allow ICMPv4 Ping` |

---

### Cara 3 — Via PowerShell

```powershell
New-NetFirewallRule -DisplayName "Allow ICMPv4" -Direction Inbound -Protocol ICMPv4 -IcmpType 8 -Action Allow
```

---

## 🔍 Verifikasi

Setelah menjalankan salah satu cara di atas, lakukan ping dari perangkat lain (misal MikroTik):

```bash
# Di terminal MikroTik
/ping 192.168.1.x
```

Jika berhasil, hasilnya akan seperti ini:
```
SEQ HOST                                     SIZE TTL TIME  STATUS
  0 192.168.1.x                                56  64 1ms
  1 192.168.1.x                                56  64 1ms
  2 192.168.1.x                                56  64 1ms
```

---

## 🔒 Keamanan

> ⚠️ Mengizinkan ICMP ping umumnya aman untuk jaringan lokal (LAN). Namun jika komputer memiliki IP publik langsung, pertimbangkan untuk membatasi rule hanya dari IP tertentu:

```cmd
netsh advfirewall firewall add rule name="Allow ICMPv4 dari MikroTik" protocol=icmpv4:8,any dir=in action=allow remoteip=192.168.1.1
```

Ganti `192.168.1.1` dengan IP perangkat yang diizinkan melakukan ping.

---

## 🗑️ Hapus Rule (Jika Tidak Diperlukan)

```cmd
netsh advfirewall firewall delete rule name="Allow ICMPv4"
```

---

## 📋 Referensi

- [Microsoft Docs - netsh advfirewall](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/netsh-advfirewall-firewall-control-firewall-behavior)
- [Windows Firewall Documentation](https://learn.microsoft.com/en-us/windows/security/operating-system-security/network-security/windows-firewall/)
