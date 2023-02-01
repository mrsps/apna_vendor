import 'dart:async';
import 'package:al/models/appuser/appuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserStore {
  final CollectionReference<Map<String, dynamic>> userStore = FirebaseFirestore.instance.collection('appUsers');
  final CollectionReference<Map<String, dynamic>> leaderVendorsStore =
      FirebaseFirestore.instance.collection('leaderVendors');

  // Getting a user by userId
  Future<AppUser?> getUser(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await userStore.doc(userId).get();
      if (documentSnapshot.exists) {
        return AppUser.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      } else
        print('User does not exist');
    } catch (error) {
      throw (error);
    }
  }

  // Getting all vendors linked to a certain leader
  Stream<List<String>> vendors(String userId) {
    return leaderVendorsStore
        .doc(userId)
        .snapshots()
        .map((snapshot) => snapshot.data() != null ? List<String>.from(snapshot.data()!['vendorIds']) : []);
  }
}
