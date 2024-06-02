import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  /*We wrap the map with a list to allow us add multiple products on the cart list
  If we don't wrap the map with a list we will only be able to accommodate a single
  product on the cart list.
  */
  final List<Map<String, dynamic>> cart = [];

  // This function adds a product to the cart list
  void addProduct(Map<String, dynamic> product) {
    cart.add(product);
    notifyListeners();
  }

  // This function removes a product from the cart list
  void removeProduct(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners();
  }
}
