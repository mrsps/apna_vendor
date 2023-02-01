import 'dart:io';
import 'package:av/models/media/media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MediaStore {
  final CollectionReference<Map<String, dynamic>> mediaStore = FirebaseFirestore.instance.collection('medias');
  final Reference storage = FirebaseStorage.instance.ref().child('media');

  // Get media url for a media entity
  Stream<String?> getUrl(String entityId) {
    return mediaStore
        .where('entityId', isEqualTo: entityId)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty ? Media.fromJson(snapshot.docs.first.data()).mediaUrl : null);
  }

  // Upload an image linked to an entity
  Future<String?> uploadImage(File image) async {
    try {
      await storage.child(basename(image.path)).putFile(image);

      return await storage.child(basename(image.path)).getDownloadURL();
    } on FirebaseException catch (e) {
      throw (e.code);
    } catch (e) {
      throw (e);
    }
  }

  // Set and link the media to the entity in fireStore
  Future<void> setMedia(Media media) async {
    try {
      await deleteMedia(media.entityId!);
      await mediaStore.doc(media.mediaId).set(media.toJson());
    } catch (error) {
      throw (error);
    }
  }

  // Delete with from both fireStore and fireStorage
  Future<void> deleteMedia(String entityId) async {
    try {
      await mediaStore
          .where('entityId', isEqualTo: entityId)
          .get()
          .then((docSnapshot) => docSnapshot.docs.forEach((doc) {
                FirebaseStorage.instance.refFromURL(doc.data()['mediaUrl']).delete();
                doc.reference.delete();
              }));
    } catch (error) {
      throw (error);
    }
  }
}
