import 'package:al/models/product/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductStore {
  final CollectionReference<Map<String, dynamic>> productStore = FirebaseFirestore.instance.collection('products');

  // List of all products for a certain vendor
  Stream<List<Product>> products(String userId, String categoryId) {
    return productStore
        .where('categoryId', isEqualTo: categoryId)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty
            ? snapshot.docs.map((doc) {
                return Product.fromJson(doc.data());
              }).toList()
            : []);
  }
}
