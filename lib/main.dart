import 'package:flutter/material.dart';

// --- 1. DEFINISI MODEL DATA ---

/// Model data untuk Kategori Produk
class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}

/// Model data untuk Produk
class Product {
  final String name;
  final IconData icon;
  final double price;
  final String category;

  Product({
    required this.name,
    required this.icon,
    required this.price,
    required this.category,
  });
}

// --- 2. DATA DUMMY (MOCK DATA) ---

final List<Category> categories = [
  Category(name: "Makanan", icon: Icons.fastfood),
  Category(name: "Minuman", icon: Icons.local_drink),
  Category(name: "Elektronik", icon: Icons.lightbulb_outline),
];

final List<Product> allProducts = [
  Product(name: "Nasi Goreng", icon: Icons.rice_bowl, price: 15000, category: "Makanan"),
  Product(name: "Mie Instan", icon: Icons.ramen_dining, price: 5000, category: "Makanan"),
  Product(name: "Air Mineral", icon: Icons.water_drop, price: 3000, category: "Minuman"),
  Product(name: "Kopi Susu", icon: Icons.coffee, price: 18000, category: "Minuman"),
  Product(name: "Headphone", icon: Icons.headset, price: 250000, category: "Elektronik"),
  Product(name: "Kabel USB", icon: Icons.usb, price: 45000, category: "Elektronik"),
  Product(name: "Televisi 4K", icon: Icons.tv, price: 5000000, category: "Elektronik"),
  // PERBAIKAN 1: Mengubah Icons.chocolate menjadi Icons.cookie
  Product(name: "Cokelat Bar", icon: Icons.cookie, price: 12000, category: "Makanan"),
];

// Fungsi untuk memformat harga menjadi mata uang IDR
String formatCurrency(double amount) {
  final String formatted = amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  return "Rp $formatted";
}

// --- 3. WIDGET UTAMA APLIKASI ---

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop Mini',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: true,
      ),
      // Awal aplikasi akan menampilkan HomeScreen
      home: const HomeScreen(),
    );
  }
}

// --- 4. HOMESCREEN: Daftar Kategori ---

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop Mini"),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Jelajahi Kategori",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Row untuk menampung 3 Card Kategori
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: categories.map((category) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CategoryCard(category: category),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget untuk Card Kategori yang dapat diklik
class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({super.key, required this.category});

  void _navigateToProductList(BuildContext context) {
    // NAVIGATE TO ProductListScreen WITH selectedCategory
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductListScreen(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToProductList(context),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(category.icon, size: 40, color: Colors.blueGrey),
              const SizedBox(height: 8),
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 5. PRODUCTLISTSCREEN: Daftar Produk dalam Grid ---

class ProductListScreen extends StatelessWidget {
  final Category category;
  const ProductListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Filter produk berdasarkan kategori yang dipilih
    final List<Product> products = allProducts
        .where((p) => p.category == category.name)
        .toList();

    return Scaffold(
      // TITLE: "[Nama Kategori]"
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Produk Kategori ${category.name}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              // Grid (2 kolom) berisi produk
              child: GridView.count(
                crossAxisCount: 2, // 2 kolom
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75, // Mengatur rasio agar card tidak terlalu pendek
                children: products.map((product) {
                  return ProductGridItem(product: product);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget untuk item produk di dalam Grid
class ProductGridItem extends StatelessWidget {
  final Product product;
  const ProductGridItem({super.key, required this.product});

  void _navigateToProductDetail(BuildContext context) {
    // NAVIGATE TO ProductDetailScreen WITH productData
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToProductDetail(context),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(product.icon, size: 50, color: Colors.blueGrey.shade700),
              const SizedBox(height: 10),
              // Label Nama Produk
              Text(
                product.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(), // Mendorong harga ke bawah
              // Label Harga Produk
              Text(
                formatCurrency(product.price),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 6. PRODUCTDETAILSCREEN: Detail Produk ---

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Produk"),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        // onTap back: NAVIGATE BACK to ProductListScreen (ditangani otomatis oleh AppBar)
      ),
      body: Center(
        // Column (centered):
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(product.icon)
            Icon(
              product.icon,
              size: 100,
              color: Colors.blueGrey,
            ),
            const SizedBox(height: 20),
            // Text(product.name)
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Text(product.price)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                formatCurrency(product.price),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.green.shade700,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // PERBAIKAN 2: Menghapus 'const' karena menggunakan interpolasi string
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "Ini adalah deskripsi singkat untuk produk ${product.name}. Detail lebih lanjut akan ditambahkan di versi berikutnya.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}