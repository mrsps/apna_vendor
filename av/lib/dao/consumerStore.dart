import 'package:av/models/consumer/consumer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsumerStore {
  final CollectionReference<Map<String, dynamic>> consumerStore = FirebaseFirestore.instance.collection('consumers');

  // Setting a new consumer linked to an order
  Future<void> setConsumer(ConsumerAddress consumer) async {
    try {
      await consumerStore.doc(consumer.consumerId).set(consumer.toJson());
    } catch (error) {
      throw (error);
    }
  }

  // Getting a consumer using a consumerId
  Future<ConsumerAddress?> getConsumer(String consumerId) async {
    try {
      DocumentSnapshot documentSnapshot = await consumerStore.doc(consumerId).get();
      if (documentSnapshot.exists) {
        return ConsumerAddress.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      }
    } catch (error) {
      throw (error);
    }
  }
}
