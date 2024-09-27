import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  // Add an item to the cart
  void addItem(Map<String, dynamic> product) {
    // Check if the product already exists in the cart
    int existingIndex = _cartItems.indexWhere((item) => item['name'] == product['name']);

    if (existingIndex >= 0) {
      // If the product already exists, increase its quantity
      _cartItems[existingIndex]['quantity'] += 1;
    } else {
      // If the product does not exist, add it with a quantity of 1
      product['quantity'] = 1;
      _cartItems.add(product);
    }

    notifyListeners();  // Notify listeners about the change
  }

  // Remove an item from the cart
  void removeItem(String productName) {
    _cartItems.removeWhere((item) => item['name'] == productName);
    notifyListeners();  // Notify listeners about the change
  }

  // Clear all items from the cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();  // Notify listeners about the change
  }

  // Calculate the total amount in the cart
  int get totalAmount {
    return _cartItems.fold(0, (sum, item) {
      return sum + ((item['price'] as int) * (item['quantity'] as int));
    });
  }

  // Adjust the quantity of a specific item
  void updateQuantity(String productName, int newQuantity) {
    int existingIndex = _cartItems.indexWhere((item) => item['name'] == productName);

    if (existingIndex >= 0) {
      // If the product exists, update its quantity
      if (newQuantity > 0) {
        _cartItems[existingIndex]['quantity'] = newQuantity;
      } else {
        // If quantity is set to 0, remove the product from the cart
        removeItem(productName);
      }
      notifyListeners();
    }
  }
}
