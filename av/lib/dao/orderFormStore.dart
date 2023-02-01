import 'package:av/helpers/randomIdMaker.dart';
import 'package:av/models/orderform/orderform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderFormStore {
  final CollectionReference<Map<String, dynamic>> orderFormStore = FirebaseFirestore.instance.collection('orderforms');

  // Get orderForm for a vendor
  Stream<OrderForm?> getOrderForm(String vendorId) {
    return orderFormStore
        .where('vendorId', isEqualTo: vendorId)
        .snapshots()
        .map((snapshot) => snapshot.docs.isEmpty ? null : OrderForm.fromJson(snapshot.docs.first.data()));
  }

  // Creating an orderForm
  Future<void> createOrderForm(String vendorId, Timestamp timestamp) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await orderFormStore.where('vendorId', isEqualTo: vendorId).get();
      if (snapshot.docs.isNotEmpty) {
        await orderFormStore.doc(snapshot.docs.first.id).set(OrderForm(
                orderFormId: snapshot.docs.first.id,
                vendorId: vendorId,
                orderFormState: OrderFormState.ACTIVE,
                timestamp: timestamp)
            .toJson());
      } else {
        String orderFormId = getRandomID('OrderForm');
        await orderFormStore.doc(orderFormId).set(OrderForm(
                orderFormId: orderFormId,
                vendorId: vendorId,
                orderFormState: OrderFormState.ACTIVE,
                timestamp: timestamp)
            .toJson());
      }
    } catch (error) {
      throw (error);
    }
  }

  // Deleting an OrderForm
  Future<void> deleteOrderForm(OrderForm orderForm) async {
    try {
      await orderFormStore
          .where('vendorId', isEqualTo: orderForm.vendorId)
          .get()
          .then((snapshot) => snapshot.docs.forEach((doc) {
                doc.reference.set(orderForm.copyWith(orderFormState: OrderFormState.INACTIVE).toJson());
              }));
    } catch (error) {
      throw (error);
    }
  }
}
