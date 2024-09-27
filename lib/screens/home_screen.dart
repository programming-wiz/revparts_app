import 'package:flutter/material.dart';
import 'shop_screen.dart'; // Import the ShopScreen class
import 'wishlist_screen.dart'; // Import the WishlistScreen class
import 'cart_screen.dart'; // Import the CartScreen class
import 'profile_screen.dart'; // Import the ProfileScreen class

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  HomePage({required this.isDarkMode, required this.toggleTheme});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePageContent(), // Home page content widget
    ShopScreen(),      // Shop page (Products)
    CartScreen(),      // Cart page
    WishlistScreen(),  // Wishlist page
    ProfileScreen(),   // Profile page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RevParts'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: _screens[_selectedIndex],  // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,  // Handle item taps
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// New HomePageContent Widget - Includes fresh layout design
class HomePageContent extends StatelessWidget {
  final List<Map<String, dynamic>> featuredProducts = [
    {'name': 'Brake Pads', 'price': 3000, 'image': 'assets/images/brakepads.jpg'},
    {'name': 'Spoiler', 'price': 5000, 'image': 'assets/images/spoiler.jpg'},
    {'name': 'Alloy Wheels', 'price': 8000, 'image': 'assets/images/tires.jpg'},
  ];

  final List<Map<String, dynamic>> categories = [
    {'name': 'Brakes', 'image': 'assets/images/brakepads.jpg'},
    {'name': 'Tires', 'image': 'assets/images/tires.jpg'},
    {'name': 'Batteries', 'image': 'assets/images/battery.jpg'},
    {'name': 'Lights', 'image': 'assets/images/lights.jpg'},
  ];

  final List<Map<String, dynamic>> bestSellers = [
    {'name': 'Car Battery', 'price': 8000, 'image': 'assets/images/battery.jpg'},
    {'name': 'Shock Absorber', 'price': 3000, 'image': 'assets/images/shockabsorber.jpg'},
  ];

  final List<Map<String, dynamic>> quickLinks = [
    {'label': 'Shop All Parts', 'icon': Icons.shopping_bag},
    {'label': 'View Promotions', 'icon': Icons.local_offer},
    {'label': 'Find Nearest Store', 'icon': Icons.store},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Section
          _bannerSection(),

          // Quick Links
          _quickLinks(),

          // Featured Products
          _sectionTitle('Featured Products'),
          _productGrid(featuredProducts),

          // Categories
          _sectionTitle('Shop by Category'),
          _categoryGrid(categories),

          // Best Sellers
          _sectionTitle('Best Sellers'),
          _productGrid(bestSellers),

          SizedBox(height: 20), // Spacing at bottom
        ],
      ),
    );
  }

  // Banner section with promotional image
  Widget _bannerSection() {
    return Container(
      margin: EdgeInsets.all(16),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage('assets/images/banner.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          'Exclusive Deals on Auto Parts!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }

  // Quick links (buttons) section
  Widget _quickLinks() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: quickLinks.map((link) {
          return _quickLinkButton(link['label'], link['icon']);
        }).toList(),
      ),
    );
  }

  // Helper method for Quick Link Button
  Widget _quickLinkButton(String label, IconData icon) {
    return Column(
      children: [
        FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {},
          child: Icon(icon, size: 28),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  // Section Title
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  // Product Grid Display
  Widget _productGrid(List<Map<String, dynamic>> products) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _productCard(product);
      },
    );
  }

  // Product Card for each item in grid
  Widget _productCard(Map<String, dynamic> product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.asset(
                product['image'],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('Rs. ${product['price']}', style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Category Grid Display
  Widget _categoryGrid(List<Map<String, dynamic>> categories) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _categoryCard(category);
      },
    );
  }

  // Category Card for each item in grid
  Widget _categoryCard(Map<String, dynamic> category) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.asset(
                category['image'],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(category['name'], textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
