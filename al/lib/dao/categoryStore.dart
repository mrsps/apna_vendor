import 'package:al/models/category/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryStore {
  final CollectionReference<Map<String, dynamic>> categoryStore = FirebaseFirestore.instance.collection('categories');

  // To get categories associated with a specific vendor
  Stream<List<Category>> categories(String userId) {
    return categoryStore.where('userId', isEqualTo: userId).snapshots().map((snapshot) => snapshot.docs.isNotEmpty
        ? snapshot.docs.map((doc) {
            return Category.fromJson(doc.data());
          }).toList()
        : []);
  }
}
