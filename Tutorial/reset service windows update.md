#### Buka Command Prompt as Administrator, lalu jalankan satu-satu:
```
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
```

lalu jalankan lagi
```
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
```

Setelah itu restart PC, lalu coba update lagi.
