🛍️ MyShop Mini (Aplikasi E-commerce Sederhana)

MyShop Mini adalah aplikasi Flutter sederhana yang didesain untuk mendemonstrasikan dasar-dasar navigasi, manajemen data lokal (mock data), dan tata letak UI (list dan grid) dalam sebuah proyek e-commerce.

🎯 Fitur Utama

Aplikasi ini mencakup tiga layar utama dengan fungsionalitas inti berikut:

Home Screen: Menampilkan daftar kategori produk (Makanan, Minuman, Elektronik) dalam format kartu horizontal.

Product List Screen: Menampilkan produk-produk yang difilter berdasarkan kategori yang dipilih dalam tata letak Grid 2 kolom.

Product Detail Screen: Menampilkan detail ikon, nama, dan harga dari produk yang dipilih.

⚙️ Struktur Proyek

Proyek ini dibangun menggunakan arsitektur widget dasar Flutter dan tidak memerlukan manajemen state yang kompleks karena menggunakan data dummy (mock data).

File/Bagian

Deskripsi Fungsionalitas

main.dart

Berisi keseluruhan aplikasi, termasuk main() dan MyApp.

Model Data

Definisi kelas Category dan Product.

Data Dummy

Daftar List<Category> dan List<Product> yang digunakan untuk mengisi UI.

HomeScreen

Menampilkan kategori dan menggunakan Row serta InkWell untuk navigasi.

ProductListScreen

Menampilkan daftar produk menggunakan GridView.count.

ProductDetailScreen

Menampilkan informasi produk yang dipilih secara terpusat.

🛠️ Cara Menjalankan Proyek

Untuk menjalankan aplikasi ini di lingkungan lokal Anda, ikuti langkah-langkah berikut:

Prasyarat

Flutter SDK (versi stabil)

IDE pilihan (Visual Studio Code atau Android Studio)

Emulator atau perangkat fisik yang terhubung.

Langkah-langkah Instalasi

Clone repositori ini (Ganti dengan perintah clone jika menggunakan Git):

# Asumsikan Anda memiliki folder proyek ini
cd my_shop_mini_project


Install dependencies Flutter:

flutter pub get


Jalankan aplikasi di perangkat atau emulator yang terhubung:

flutter run


Atau, gunakan tombol Run atau Debug di IDE Anda.

📝 Widget Utama yang Digunakan

Widget

Tujuan dalam Proyek

Scaffold

Menyediakan tata letak layar dasar (AppBar & Body).

Column, Row

Mengatur widget secara vertikal dan horizontal.

InkWell, Navigator

Menangani tap pada kategori/produk dan mengelola perpindahan antar layar.

Card

Memberikan tampilan visual yang rapi dan terpisah untuk setiap item.

GridView.count

Mengatur daftar produk menjadi 2 kolom di ProductListScreen.

StatelessWidget

Digunakan untuk semua layar karena data statis (model data dilewatkan antar widget).
