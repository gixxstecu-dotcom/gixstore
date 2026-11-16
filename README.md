# GIX STORE — Glassmorphism Edition

Starter Next.js untuk toko digital GIX STORE dengan tampilan glassmorphism biru, QRIS GoPay asli dari gambar yang kamu kirim, checkout upload bukti, dan admin panel.

## Fitur
- Katalog produk Supabase.
- Login admin via Supabase Auth.
- CRUD produk, harga, kategori, aktif/nonaktif.
- Checkout QRIS statis: pembeli memasukkan nominal sendiri dan upload bukti.
- Admin mencocokkan transaksi asli di GoPay Merchant, lalu tandai Lunas/Tolak/Selesai Dikirim.
- Tombol WhatsApp untuk menghubungi pembeli.
- Konfigurasi Vercel dan Netlify.

## Supabase setup
1. Buat project Supabase, jalankan `supabase/schema.sql` di SQL Editor.
2. Authentication > Users: buat akun admin sendiri dan matikan public sign-up.
3. Storage: buat bucket public `payment-proofs`.
4. Bucket policy: izinkan `anon` INSERT dan `authenticated` SELECT pada bucket `payment-proofs`.
5. Isi `.env.local` dengan URL dan anon key Supabase (lihat `.env.example`).
6. Tambahkan produk setelah login ke `/admin`.

## Local run
```bash
cp .env.example .env.local
npm install
npm run dev
```
Buka http://localhost:3000

## Vercel
Import repo GitHub ke Vercel, isi environment variables dari `.env.example`, lalu deploy.

## Netlify
Import repo ke Netlify. Build command `npm run build`; plugin Next.js sudah ditulis di `netlify.toml`. Isi environment variables yang sama, lalu deploy.

## QRIS & keamanan
QRIS yang kamu kirim ada di `public/images/qris-gix.png`. Untuk mengganti QRIS, ganti file itu lalu deploy ulang.
Order selalu masuk sebagai `pending`. Screenshot tidak otomatis membuktikan pembayaran. Admin wajib cocokkan nominal, waktu, dan transaksi di GoPay Merchant sebelum menekan “Tandai Lunas”.
Jangan membuat policy publik untuk membaca atau mengubah pesanan. Batasi akun Supabase Auth hanya untuk admin. Uji semua alur sebelum menerima pembayaran sungguhan.

## Batasan starter
Pengiriman produk dilakukan admin secara manual melalui WhatsApp. Upload QRIS dari admin panel belum disediakan; penggantian QRIS dilakukan lewat file project dan deploy ulang. Ini project starter yang perlu dikonfigurasi dengan Supabase milikmu sebelum online.
