import 'package:av/dao/mediaStore.dart';
import 'package:av/models/product/product.dart';
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

  // Getting cart sum for all products with certain quantities
  Future<double?> getCartSum(Map<String, int> quantities) async {
    double sum = 0;
    try {
      for (String productId in quantities.keys) {
        Product? product = await getProduct(productId);
        if (product != null) {
          sum += product.productPrice! * quantities[productId]!;
        }
      }
      return sum;
    } catch (error) {
      throw (error);
    }
  }

  // Get product from a product Id
  Future<Product?> getProduct(String productId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await productStore.doc(productId).get();
      if (doc.data()!.isEmpty)
        return null;
      else
        return Product.fromJson(doc.data()!);
    } catch (error) {
      throw (error);
    }
  }

  // Set product for a certain vendor
  Future<void> setProduct(Product product) async {
    try {
      await productStore.doc(product.productId).set(product.toJson());
    } catch (error) {
      throw (error);
    }
  }

  // Delete the product from the catalogue
  Future<void> deleteProduct(String productId) async {
    try {
      await productStore.doc(productId).delete();
      await MediaStore().deleteMedia(productId);
    } catch (error) {
      throw (error);
    }
  }

  // Checks if a category is empty or not
  Future<bool> productExists(String categoryId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshots =
          await productStore.where('categoryId', isEqualTo: categoryId).get();
      return snapshots.docs.isNotEmpty;
    } catch (error) {
      throw (error);
    }
  }
}
