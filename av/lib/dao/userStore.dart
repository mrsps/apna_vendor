import 'dart:async';
import 'package:av/models/appuser/appuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserStore {
  final CollectionReference<Map<String, dynamic>> userStore = FirebaseFirestore.instance.collection('appUsers');
  final CollectionReference<Map<String, dynamic>> leaderVendorsStore =
      FirebaseFirestore.instance.collection('leaderVendors');

  // Setting the user
  Future<void> setUser(AppUser appUser) async {
    try {
      await userStore.doc(appUser.userId).set(appUser.toJson());
    } catch (error) {
      throw (error);
    }
  }

  // Getting a user by userId
  Future<AppUser?> getUser(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await userStore.doc(userId).get();
      if (documentSnapshot.exists) {
        return AppUser.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      }
    } catch (error) {
      throw error;
    }
  }

  // Getting userId by phone number
  Future<String?> getUserIdByPhone(String phone) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await userStore.where('userPhone', isEqualTo: phone).get();
      if(snapshot.docs.isNotEmpty)return snapshot.docs.first.id;
    } catch (error) {
      throw (error);
    }
  }

  // Add vendor linking him to a specific leader
  Future<void> addVendor(String vendorId, String leaderId) async {
    try {
      await leaderVendorsStore.doc(leaderId).set({
        'vendorIds': FieldValue.arrayUnion([vendorId])
      }, SetOptions(merge: true));
    } catch (error) {
      throw (error);
    }
  }

  // Deleting a vendor linked with a leader
  Future<void> deleteVendor(String vendorId, String leaderId) async {
    try {
      await leaderVendorsStore.doc(leaderId).update({
        'vendorIds': FieldValue.arrayRemove([vendorId])
      });
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
