import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FireNotify {
  final leaderId;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FireNotify(this.leaderId) {
    // startNotifications();
  }

  // Notification permission ask function (currently not operable)
  Future<void> startNotifications() async {
    try {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        String? token = await messaging.getToken(
          vapidKey: 'BLmVud_z4b6K7ul-OXuSTCBbA8UP-0NKXxcQ-h36ZGoWDG-1wd5tDo2Ds6t_HcnASqA3-HWqbQ0YDadxDw__w7Y',
        );
        await FirebaseFirestore.instance.collection('deviceTokens').doc(leaderId).set({
          'tokens': FieldValue.arrayUnion([token]),
        }, SetOptions(merge: true));
      }
    } catch (error) {
      throw error;
    }
  }
}
