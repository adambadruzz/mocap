import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreatePostViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createPost(String title, String description, List<File> selectedImages) async {
    final user = _auth.currentUser;
    if (user != null) {
      // Upload selected images to Firebase Storage
      final List<String> imageUrls = await _uploadImages(selectedImages);

      // Create a new post document in Firestore
      final post = {
        'title': title,
        'description': description,
        'images': imageUrls,
      };

      await _firestore.collection('posts').add(post);

      // Navigate back to the previous screen
      Get.back();
    }
  }

  Future<List<String>> _uploadImages(List<File> images) async {
    final List<String> imageUrls = [];

    for (final imageFile in images) {
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('post_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});

      if (snapshot.state == firebase_storage.TaskState.success) {
        final imageUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
    }

    return imageUrls;
  }
}
