import 'package:flutter/material.dart';
import 'product_detail_screen.dart';  // Import the ProductDetailScreen

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  // Initial list of products
  List<Map<String, dynamic>> products = [
    {'name': 'Brake Pads', 'price': 3000, 'image': 'assets/images/brakepads.jpg', 'category': 'Brakes', 'rating': 4.5},
    {'name': 'Tires', 'price': 5000, 'image': 'assets/images/tires.jpg', 'category': 'Tires', 'rating': 4.2},
    {'name': 'Car Battery', 'price': 8000, 'image': 'assets/images/battery.jpg', 'category': 'Batteries', 'rating': 4.8},
    {'name': 'Air Filter', 'price': 10000, 'image': 'assets/images/filter.jpg', 'category': 'Filters', 'rating': 4.0},
    {'name': 'LED Headlights', 'price': 6000, 'image': 'assets/images/headlight.jpg', 'category': 'Lights', 'rating': 4.1},
    {'name': 'Spark Plugs', 'price': 4500, 'image': 'assets/images/sparkplug.jpg', 'category': 'Plugs', 'rating': 3.9},
    {'name': 'Rear Spoiler', 'price': 7000, 'image': 'assets/images/spoiler.jpg', 'category': 'Exterior', 'rating': 4.6},
    {'name': 'Shock Absorber', 'price': 1500, 'image': 'assets/images/shockabsorber.jpg', 'category': 'Suspension', 'rating': 4.4},
    {'name': 'Radiator', 'price': 1200, 'image': 'assets/images/radiator.jpg', 'category': 'Cooling', 'rating': 4.3},
    // Add more products as needed
  ];

  String selectedCategory = 'All'; // Filter by category
  String selectedSort = 'Price: Low to High'; // Sort option
  List<String> categories = ['All', 'Brakes', 'Tires', 'Batteries', 'Filters', 'Lights', 'Plugs', 'Exterior', 'Suspension', 'Cooling'];

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;

    // Filter products based on the selected category
    List<Map<String, dynamic>> filteredProducts = selectedCategory == 'All'
        ? products
        : products.where((product) => product['category'] == selectedCategory).toList();

    // Sort products based on selected sorting option
    filteredProducts.sort((a, b) {
      if (selectedSort == 'Price: Low to High') {
        return a['price'].compareTo(b['price']);
      } else if (selectedSort == 'Price: High to Low') {
        return b['price'].compareTo(a['price']);
      }
      return 0;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
      ),
      body: Column(
        children: [
          // Promotional banner
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.redAccent,
            width: double.infinity,
            child: Center(
              child: Text(
                'Hot Deals! Get 20% Off on Select Items!',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Filter and Sort Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                // Category Dropdown
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10),
                // Sort Dropdown
                DropdownButton<String>(
                  value: selectedSort,
                  onChanged: (value) {
                    setState(() {
                      selectedSort = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: 'Price: Low to High',
                      child: Text('Price: Low to High'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Price: High to Low',
                      child: Text('Price: High to Low'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 3,  // 2 items per row in portrait, 3 in landscape
                childAspectRatio: 3 / 4,  // Aspect ratio for the product card
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to ProductDetailScreen when a product is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          productName: product['name'],
                          price: product['price'],
                          imageUrl: product['image'],
                        ),
                      ),
                    );
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corner effect
                      splashColor: Colors.red.withOpacity(0.2), // Ripple effect color
                      child: Card(
                        elevation: 2,
                        child: Column(
                          children: [
                            // Display the product image
                            Expanded(
                              child: Image.asset(
                                product['image'],
                                fit: BoxFit.cover,  // Ensure the image covers the available space
                              ),
                            ),
                            SizedBox(height: 10),
                            // Product name and price
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(product['name'], style: TextStyle(fontSize: 16)),
                                  SizedBox(height: 5),
                                  Text(
                                    'Rs.${product['price']}',
                                    style: TextStyle(fontSize: 14, color: Colors.green),
                                  ),
                                  SizedBox(height: 5),
                                  // Display product rating
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(5, (i) {
                                      return Icon(
                                        i < product['rating'].toInt()
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.yellow,
                                        size: 16,
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
