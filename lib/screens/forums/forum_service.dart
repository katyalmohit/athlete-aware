import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ForumService {
  /// Uploads a file (image or video) to Firebase Storage and returns the file URL.
  static Future<String?> uploadFileToFirebase(File file) async {
    try {
      // Generate a unique file name based on the current timestamp
      final ref = FirebaseStorage.instance
          .ref()
          .child('forum_uploads/${DateTime.now().millisecondsSinceEpoch}');
      // Upload the file
      final uploadTask = await ref.putFile(file);
      // Get the download URL of the uploaded file
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      // Log the error and return null
      print('File upload error: $e');
      return null;
    }
  }

  /// Adds a new post to Firestore with the specified details.
  static Future<void> addPostToFirestore({
    required String message,
    String? fileUrl,
    required String userId,
    required String userName,
  }) async {
    try {
      // Add the post document to the "forum_posts" collection
      await FirebaseFirestore.instance.collection('forum_posts').add({
        'userId': userId, // ID of the user posting
        'userName': userName, // Name of the user posting
        'time': DateTime.now().toString(), // Current timestamp
        'message': message, // Message content
        'fileUrl': fileUrl, // File URL (if any)
        'likes': 0, // Initial like count
        'comments': 0, // Initial comment count
      });
    } catch (e) {
      // Log the error if adding the post fails
      print('Error adding post to Firestore: $e');
    }
  }

  /// Retrieves a stream of posts from Firestore ordered by time (latest first).
  static Stream<QuerySnapshot> getPostsStream() {
    return FirebaseFirestore.instance
        .collection('forum_posts')
        .orderBy('time', descending: true)
        .snapshots();
  }
}
