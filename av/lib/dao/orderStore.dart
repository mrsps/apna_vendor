import 'package:av/dao/consumerStore.dart';
import 'package:av/helpers/randomIdMaker.dart';
import 'package:av/models/consumer/consumer.dart';
import 'package:av/models/order/order.dart';
import 'package:av/models/product/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderStore {
  final CollectionReference<Map<String, dynamic>> orderStore = FirebaseFirestore.instance.collection('orders');

  // Getting all orders for a specific leader
  Stream<List<Order>> ordersLeader(String leaderId) {
    return orderStore.where('leaderId', isEqualTo: leaderId).orderBy('timestamp').limit(100).snapshots().map(
          (snapshot) => snapshot.docs.isNotEmpty
              ? snapshot.docs
                  .map((doc) {
                    return Order.fromJson(doc.data());
                  })
                  .toList()
                  .reversed
                  .toList()
              : [],
        );
  }

  // Getting all orders for a specific vendor
  Stream<List<Order>> ordersVendor(String vendorId) {
    return orderStore.where('vendorId', isEqualTo: vendorId).orderBy('timestamp').limit(100).snapshots().map(
          (snapshot) => snapshot.docs.isNotEmpty
              ? snapshot.docs
                  .map((doc) {
                    return Order.fromJson(doc.data());
                  })
                  .toList()
                  .reversed
                  .toList()
              : [],
        );
  }

  // Check if a product is present in open orders
  Future<bool> orderProductExists(String productId, String vendorId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshots = await orderStore
          .where('vendorId', isEqualTo: vendorId)
          .where('orderState', whereIn: ['CREATED', 'SHIPPED']).get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshots.docs) {
        Map<String, dynamic> products = doc.data()['products'];
        if (products.keys.contains(productId)) {
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (error) {
      throw (error);
    }
  }

  // Checking if vendor is having any open orders
  Future<bool> orderVendorExists(String vendorId, String leaderId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshots = await orderStore
          .where('vendorId', isEqualTo: vendorId)
          .where('leaderId', isEqualTo: leaderId)
          .where('orderState', whereIn: ['CREATED', 'SHIPPED']).get();
      return snapshots.docs.isNotEmpty;
    } catch (error) {
      throw (error);
    }
  }

  // Setting a new order
  Future<void> setOrder(Order order) async {
    try {
      await orderStore.doc(order.orderId).set(order.toJson());
    } catch (error) {
      throw (error);
    }
  }

  // Creating a new order
  Future<void> createOrder(
      Map<String, int> quantities, ConsumerAddress consumer, String leaderId, List<Product> products) async {
    print(leaderId);
    print(products);
    print(consumer);
    Map<String, Map<String, int>> vendorsProducts = {};

    products.forEach((Product product) {
      if (!vendorsProducts.containsKey(product.userId!)) {
        vendorsProducts[product.userId!] = {};
      }
      vendorsProducts[product.userId!]!.addAll({product.productId!: quantities[product.productId!]!});
    });
    print(vendorsProducts);

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
