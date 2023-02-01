import 'package:al/models/consumer/consumer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsumerStore {
  final CollectionReference<Map<String, dynamic>> consumerStore = FirebaseFirestore.instance.collection('consumers');

  // Function to set a consumer
  Future<void> setConsumer(ConsumerAddress consumer) async {
    try {
      await consumerStore.doc(consumer.consumerId).set(consumer.toJson());
    } catch (error) {
      throw (error);
    }
  }
}
