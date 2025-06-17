import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Main entry point for the application
void main() {
  runApp(const GadgetApp());
}

// The root widget of the application
class GadgetApp extends StatelessWidget {
  const GadgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gadget Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: 'Poppins', // A modern and clean font
      ),
      home: const DashboardScreen(),
    );
  }
}

// The main dashboard screen
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // Handler for bottom navigation bar taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 24),
              _buildBanner(),
              const SizedBox(height: 24),
              _buildSectionTitle('Categories'),
              const SizedBox(height: 16),
              _buildCategories(),
              const SizedBox(height: 24),
              _buildSectionTitle('Special for You'),
              const SizedBox(height: 16),
              _buildSpecialForYou(),
              const SizedBox(height: 24),
              _buildSectionTitle('Popular Products'),
              const SizedBox(height: 16),
              _buildPopularProducts(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Builds the top AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'Gadget Store',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(CupertinoIcons.bell, color: Colors.black),
          onPressed: () {
            // TODO: Implement notification logic
          },
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://placehold.co/100x100/EFEFEF/333333?text=User',
            ),
          ),
        ),
      ],
    );
  }

  // Builds the search bar widget
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for gadgets...',
        prefixIcon: const Icon(CupertinoIcons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Builds the promotional banner
  Widget _buildBanner() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: const LinearGradient(
          colors: [Colors.indigo, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Latest Gadgets!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Up to 30% OFF',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
            // You can add an image here
            // Image.network('your_image_url', width: 120),
          ],
        ),
      ),
    );
  }

  // Generic widget for section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  // Builds the categories list
  Widget _buildCategories() {
    final categories = [
      {'icon': CupertinoIcons.device_phone_portrait, 'name': 'Phones'},
      {'icon': CupertinoIcons.device_laptop, 'name': 'Laptops'},
      {'icon': CupertinoIcons.headphones, 'name': 'Audio'},
      {'icon': CupertinoIcons.game_controller, 'name': 'Gaming'},
      {'icon': CupertinoIcons.camera, 'name': 'Cameras'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    color: Colors.indigo,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category['name'] as String,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Builds the horizontally scrolling "Special for You" section
  Widget _buildSpecialForYou() {
    final products = [
      {
        'name': 'Smart Watch X',
        'price': '\$299',
        'image': 'https://placehold.co/300x300/F0F0F0/333333?text=Watch+X',
      },
      {
        'name': 'Pro Headphones',
        'price': '\$199',
        'image': 'https://placehold.co/300x300/E0E0E0/333333?text=Headphones',
      },
      {
        'name': 'VR Headset',
        'price': '\$499',
        'image': 'https://placehold.co/300x300/D0D0D0/333333?text=VR',
      },
    ];

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildProductCard(product);
        },
      ),
    );
  }

  // Builds the "Popular Products" grid
  Widget _buildPopularProducts() {
    final products = [
      {
        'name': 'Gaming Mouse',
        'price': '\$79',
        'image': 'https://placehold.co/300x300/C0C0C0/333333?text=Mouse',
      },
      {
        'name': '4K Drone',
        'price': '\$899',
        'image': 'https://placehold.co/300x300/B0B0B0/333333?text=Drone',
      },
      {
        'name': 'Tablet Pro',
        'price': '\$649',
        'image': 'https://placehold.co/300x300/A0A0A0/333333?text=Tablet',
      },
      {
        'name': 'Smart Speaker',
        'price': '\$129',
        'image': 'https://placehold.co/300x300/909090/333333?text=Speaker',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductCard(product, isPopular: true);
      },
    );
  }

  // Reusable widget for displaying a product
  Widget _buildProductCard(
    Map<String, String> product, {
    bool isPopular = false,
  }) {
    return Container(
      width: isPopular ? null : 160,
      margin: isPopular ? null : const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12.0),
              ),
              child: Image.network(
                product['image']!,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder:
                    (context, error, stackTrace) => const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product['price']!,
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Builds the modern bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_grid_2x2),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
      ),
    );
  }
}
