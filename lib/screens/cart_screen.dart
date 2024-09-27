import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/cart_provider.dart';  // Import CartProvider

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;
    final totalAmount = cartProvider.totalAmount;

    // Assuming a flat delivery charge
    const deliveryCharge = 500;
    final grandTotal = totalAmount + deliveryCharge;

    // Detect the orientation of the device
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          // Clear cart button in the AppBar
          if (cartItems.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Clear the cart
                cartProvider.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cart cleared!')),
                );
              },
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text(
          'Your cart is empty!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : Column(
        children: <Widget>[
          // Cart items list
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Dismissible(
                  key: Key(item['name']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    // Remove the item from the cart
                    cartProvider.removeItem(item['name']);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item['name']} removed from cart')),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(item['image'], width: 60, height: 60),  // Product image
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['name'], style: TextStyle(fontSize: 16)),  // Product name
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove_circle_outline),
                                      onPressed: () {
                                        if (item['quantity'] > 1) {
                                          cartProvider.updateQuantity(item['name'], item['quantity'] - 1);
                                        }
                                      },
                                    ),
                                    Text('${item['quantity']}'),  // Quantity
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        cartProvider.updateQuantity(item['name'], item['quantity'] + 1);
                                      },
                                    ),
                                  ],
                                ),
                                Text('Rs.${item['price']} x ${item['quantity']}'),
                                SizedBox(height: 5),
                                Text('Subtotal: Rs.${(item['price'] * item['quantity']).toInt()}'),
                              ],
                            ),
                          ),
                          Text(
                            'Rs.${(item['price'] * item['quantity']).toInt()}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Use bottomNavigationBar to place totals and checkout button at the bottom
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,  // Ensures content takes minimum space
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Subtotal:'),  // Subtotal label
                Text('Rs.$totalAmount'),  // Subtotal amount
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Delivery Charge:'),  // Delivery charge label
                Text('Rs.$deliveryCharge'),  // Delivery charge amount
              ],
            ),
            Divider(thickness: 1, color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Grand Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),  // Grand total label
                Text(
                  'Rs.$grandTotal',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),  // Grand total amount
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: cartItems.isNotEmpty
                  ? () {
                // Handle checkout logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Proceeding to Checkout!')),
                );
              }
                  : null,  // Disable the button if the cart is empty
              child: Text('Checkout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
