# 🖥️ Windows vs Linux — Networking Command Cheat Sheet

> Referensi cepat perintah jaringan untuk Windows dan Linux secara berdampingan.

---

| Task | Windows | Linux |
|------|---------|-------|
| 🌐 Show IP configuration | `ipconfig` | `ip addr show` |
| ℹ️ Detailed network info | `ipconfig /all` | `ip addr show` |
| ⬇️ Release IP address | `ipconfig /release` | `sudo dhclient -r <iface>` |
| ⬆️ Renew IP address | `ipconfig /renew` | `sudo dhclient <iface>` |
| 🔵 Flush DNS cache | `ipconfig /flushdns` | `sudo resolvectl flush-caches` |
| 📶 Ping a host | `ping google.com` | `ping google.com` |
| 🔄 Continuous ping | `ping -t google.com` | `ping google.com` *(Ctrl+C to stop)* |
| 📍 Trace network path | `tracert google.com` | `traceroute google.com` |
| 🔍 DNS lookup | `nslookup google.com` | `nslookup google.com` |
| 🗺️ View routing table | `route print` | `ip route show` |
| 📋 Display ARP table | `arp -a` | `ip neigh show` |
| 🔌 Check listening ports | `netstat -ano` | `ss -tuln` |
| 🔗 Test TCP port connectivity | `telnet host port` atau `Test-NetConnection` | `nc -zv host port` |
| 📊 Network statistics | `netstat -e` | `ip -s link` |
| 👥 Show active connections | `netstat -an` | `ss -tan` |
| 🖧 Display MAC address | `getmac` | `ip link show` |
| 💻 Display hostname | `hostname` | `hostname` |
| 🔐 SSH into remote system | `ssh user@host` | `ssh user@host` |
| 📁 Secure copy files | `scp file user@host:/path` | `scp file user@host:/path` |

---

## 📝 Catatan Tambahan

### Windows
- Jalankan **Command Prompt sebagai Administrator** untuk perintah yang membutuhkan hak akses lebih.
- `Test-NetConnection` adalah alternatif modern dari `telnet` di PowerShell.

### Linux
- Gunakan `sudo` untuk perintah yang memerlukan hak akses root.
- `ss` adalah pengganti modern dari `netstat` pada distro Linux terbaru.
- Ganti `<iface>` dengan nama interface yang sesuai, misalnya `eth0` atau `ens3`.

---

*Cheat sheet ini berguna untuk administrator jaringan, teknisi NOC, maupun pelajar IT.*
