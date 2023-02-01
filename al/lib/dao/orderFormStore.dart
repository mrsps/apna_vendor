import 'package:al/models/orderform/orderform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderFormStore {
  final CollectionReference<Map<String, dynamic>> orderFormStore = FirebaseFirestore.instance.collection('orderforms');

  // Get orderForm state for a specific vendor
  Stream<OrderForm?> getOrderForm(String vendorId) {
    return orderFormStore
        .where('vendorId', isEqualTo: vendorId)
        .snapshots()
        .map((snapshot) => snapshot.docs.isEmpty ? null : OrderForm.fromJson(snapshot.docs.first.data()));
  }
}
