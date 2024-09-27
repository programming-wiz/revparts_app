import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/cart_provider.dart';  // Import CartProvider

class ProductDetailScreen extends StatelessWidget {
  final String productName;
  final int price;
  final String imageUrl;

  ProductDetailScreen({
    required this.productName,
    required this.price,
    required this.imageUrl,
  });

  // Mock data for product description, rating, and reviews
  final String description = 'High-quality, durable brake pads designed for maximum safety and performance. Compatible with most vehicles and easy to install.';
  final double rating = 4.5;  // Example product rating
  final List<Map<String, dynamic>> reviews = [
    {
      'username': 'John Doe',
      'review': 'Excellent product! Works perfectly.',
      'rating': 5,
    },
    {
      'username': 'Jane Smith',
      'review': 'Good quality, but a bit expensive.',
      'rating': 4,
    },
    {
      'username': 'Mark Johnson',
      'review': 'Satisfied with the purchase.',
      'rating': 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Product image
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Product name and price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                productName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Rs.$price',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),

            // Product description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 20),

            // Product rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'Rating: $rating',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating.toInt() ? Icons.star : Icons.star_border,
                        color: Colors.yellow,
                        size: 20,
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Add to Cart button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add the product to the cart
                  cartProvider.addItem({
                    'name': productName,
                    'price': price,
                    'quantity': 1,  // Default quantity as 1
                    'image': imageUrl,
                  });

                  // Show a confirmation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$productName added to cart'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Reviews Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Customer Reviews',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),

            // List of reviews
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.grey),
                    title: Text(review['username']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review['review']),
                        Row(
                          children: List.generate(5, (i) {
                            return Icon(
                              i < review['rating'] ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
                              size: 16,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
