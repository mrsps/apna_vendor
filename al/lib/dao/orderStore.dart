import 'package:al/dao/consumerStore.dart';
import 'package:al/helpers/randomIdMaker.dart';
import 'package:al/models/consumer/consumer.dart';
import 'package:al/models/order/order.dart';
import 'package:al/models/product/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderStore {
  final CollectionReference<Map<String, dynamic>> orderStore = FirebaseFirestore.instance.collection('orders');

  // Function to create order
  Future<void> createOrder(
      Map<String, int> quantities, ConsumerAddress consumer, String leaderId, List<Product> products) async {
    Map<String, Map<String, int>> vendorsProducts = {};

    products.forEach((Product product) {
      if (!vendorsProducts.containsKey(product.userId!)) {
        vendorsProducts[product.userId!] = {};
      }
      vendorsProducts[product.userId!]!.addAll({product.productId!: quantities[product.productId!]!});
    });

    try {
      await ConsumerStore().setConsumer(consumer);
      vendorsProducts.forEach((key, value) async {
        String orderId = getRandomID('Order');
        await orderStore.doc(orderId).set(Order(
                orderId: orderId,
                orderState: OrderState.CREATED,
                paymentState: PaymentState.PENDING,
                products: value,
                vendorId: key,
                leaderId: leaderId,
                consumerId: consumer.consumerId,
                timestamp: Timestamp.now())
            .toJson());
      });
    } catch (error) {
      throw (error);
    }
  }
}
