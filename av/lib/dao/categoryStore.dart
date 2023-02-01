import 'package:av/models/category/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryStore {
  final CollectionReference<Map<String, dynamic>> categoryStore = FirebaseFirestore.instance.collection('categories');

  // List of categories fot a specific vendor
  Stream<List<Category>> categories(String userId) {
    return categoryStore.where('userId', isEqualTo: userId).snapshots().map(
          (snapshot) => snapshot.docs.isNotEmpty
              ? snapshot.docs.map((doc) {
                  return Category.fromJson(doc.data());
                }).toList()
              : [],
        );
  }

  // Set category
  Future<void> setCategory(Category category) async {
    try {
      await categoryStore.doc(category.categoryId).set(category.toJson());
    } catch (error) {
      throw (error);
    }
  }

  // Delete a category
  Future<void> deleteCategory(Category category) async {
    try {
      await categoryStore.doc(category.categoryId).delete();
    } catch (error) {
      throw (error);
    }
  }
}
