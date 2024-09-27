import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  final List<Map<String, dynamic>> wishlistItems = [
    {
      'name': 'Brake Pads',
      'price': 3000,
      'image': 'assets/images/brakepads.jpg',
      'description': 'High-performance brake pads suitable for all types of cars.',
    },
    {
      'name': 'Alloy Wheels',
      'price': 8000,
      'image': 'assets/images/tires.jpg',
      'description': 'Durable and lightweight alloy wheels for improved handling.',
    },
    // You can add more items here, ensuring all fields are non-null
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Wishlist'),
        centerTitle: true,
      ),
      body: wishlistItems.isNotEmpty
          ? Column(
        children: [
          // Banner section at the top of the wishlist
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.blueGrey,
            width: double.infinity,
            child: Center(
              child: Text(
                'Here are the items you\'ve saved for later!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistItems[index];

                // Use default values in case any field is null
                final itemName = item['name'] ?? 'Unnamed Item';
                final itemPrice = item['price']?.toString() ?? 'Price not available';
                final itemImage = item['image'] ?? 'assets/images/default.jpg'; // Use a default image path
                final itemDescription = item['description'] ?? 'No description available';

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            itemImage,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 15),

                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Name
                              Text(
                                itemName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),

                              // Product Description
                              Text(
                                itemDescription,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10),

                              // Price
                              Text(
                                'Rs. $itemPrice',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Action Buttons (Move to Cart, Delete)
                        Column(
                          children: [
                            // Move to Cart Button
                            IconButton(
                              icon: Icon(Icons.shopping_cart, color: Colors.green),
                              onPressed: () {
                                // Move to cart logic
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('$itemName moved to cart'),
                                  ),
                                );
                              },
                            ),
                            // Delete Button
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Remove item from wishlist logic
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('$itemName removed from wishlist'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 100,
              color: Colors.grey[400],
            ),
            SizedBox(height: 20),
            Text(
              'Your wishlist is empty!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the shop page
                Navigator.pushNamed(context, '/shop');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text('Start Shopping', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
