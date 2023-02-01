import 'package:al/models/media/media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MediaStore {
  final CollectionReference<Map<String, dynamic>> mediaStore = FirebaseFirestore.instance.collection('medias');
  final Reference storage = FirebaseStorage.instance.ref().child('media');

  // Get media url for a specific entity
  Stream<String?> getUrl(String entityId) {
    return mediaStore
        .where('entityId', isEqualTo: entityId)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty ? Media.fromJson(snapshot.docs.first.data()).mediaUrl : null);
  }
}
