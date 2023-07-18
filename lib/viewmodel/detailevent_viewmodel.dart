import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/post_model.dart';
import '../view/home_view.dart';

class DetailEventViewModel extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  RxBool hasSpecialRole = false.obs;
  final PostModel post;

  DetailEventViewModel({required this.post});

  @override
  void onInit() {
    checkSpecialRole();
    super.onInit();
  }

  Future<void> checkSpecialRole() async {
    final snapshot = await _firestore.collection('posts').doc(post.id).get();
    final postData = snapshot.data() as Map<String, dynamic>;
    final hasSpecialRoleValue = postData['specialRole'] ?? false;
    hasSpecialRole.value = hasSpecialRoleValue;
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Event'),
          content: const Text('Are you sure you want to delete this event?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                deleteEvent(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteEvent(BuildContext context) async {
    try {
      await _firestore.collection('posts').doc(post.id).delete();

      final List<String> imageUrls = post.images;
      for (final imageUrl in imageUrls) {
        final fileName = imageUrl.split('%2F').last.split('?').first;
        final storageRef = _firebaseStorage.ref().child('post_images/$fileName');
        await storageRef.delete();
      }

      Get.offAll(() => HomeView());
    } catch (e) {
      print('Error deleting event: $e');
    }
  }
}
