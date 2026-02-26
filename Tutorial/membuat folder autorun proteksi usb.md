📁 Tutorial Membuat Folder autorun.inf

Tutorial ini menjelaskan cara membuat folder bernama autorun.inf di Windows untuk kebutuhan tertentu (misalnya proteksi USB dari virus yang suka bikin file autorun).

✅ 1. Buka Command Prompt

Tekan:

Windows + R

Lalu ketik:

cmd

✅ 2. Masuk ke Drive yang Mau Dibuat

Misal di flashdisk drive E:

E:

✅ 2. Masuk ke Drive yang Mau Dibuat

Misal di flashdisk drive E:

E:

✅ 3. Buat Folder autorun.inf

Ketik:

mkdir autorun.inf

✅ 4. Kunci Folder Supaya Tidak Bisa Dihapus
attrib +r +s +h autorun.inf

Artinya:

+r = read only

+s = system

+h = hidden

Folder jadi tersembunyi & lebih aman.

✅ 5. Cara Cek Berhasil

Ketik:

dir /a

Kalau muncul autorun.inf berarti sukses 🎉

❗ Catatan Penting

Folder ini biasanya dipakai supaya virus tidak bisa bikin file autorun.inf sendiri.

Kalau mau hapus:

attrib -r -s -h autorun.inf
rmdir autorun.inf
📌 Tips Tambahan

Kalau di Explorer tidak kelihatan:

Buka View

Centang Hidden items

Matikan Hide protected operating system files
