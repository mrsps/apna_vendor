import 'package:al/models/product/product.dart';
import 'package:flutter/material.dart';

class OrderManager with ChangeNotifier {
  // LeaderId associated with the leader
  final leaderId;
  OrderManager(this.leaderId);

  // Quantities of each product in the cart
  Map<String, int> quantities = {};
  // List of each product in the cart
  List<Product> products = [];
  // Total price of the cart
  double total = 0;

  // Function to reset the cart
  void reset() {
    quantities = {};
    products = [];
    total = 0;
    notifyListeners();
  }

  // Function to add product in the cart
  void addProduct(Product product) {
    products.add(product);
    quantities[product.productId!] = product.productMinimumQuantity!;
    total = setTotal();
    notifyListeners();
  }

  // Function to delete product from the cart
  void deleteProduct(Product product) {
    products.remove(product);
    quantities.removeWhere((key, value) => key == product.productId);
    total = setTotal();
    notifyListeners();
  }

  // Increment the quantity of a specific product
  void increment(Product product) {
    if (quantities[product.productId] != 20) {
      quantities[product.productId!] = quantities[product.productId!]! + 1;
    }
    total = setTotal();
    notifyListeners();
  }

  // Decrement the quantity of a specific product
  void decrement(Product product) {
    if (quantities[product.productId] != product.productMinimumQuantity) {
      quantities[product.productId!] = quantities[product.productId!]! - 1;
    }
    total = setTotal();
    notifyListeners();
  }

  // Function to initialize the total price of the cart
  double setTotal() {
    double ans = 0;
    products.forEach((product) {
      ans += product.productPrice! * quantities[product.productId]!;
    });
    return ans;
  }
}
