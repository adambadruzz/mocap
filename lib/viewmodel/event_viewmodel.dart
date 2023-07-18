import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/post_model.dart';
import '../view/createpost_view.dart';

class EventViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isPengurus = false;

  bool get isPengurus => _isPengurus;

  @override
  void onInit() {
    super.onInit();
    _checkPengurusRole();
  }

  Stream<List<PostModel>> getPostsStream() {
    return _firestore.collection('posts').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
      },
    );
  }

  void _checkPengurusRole() async {
    final user = _auth.currentUser;
    if (user != null) {
      final docSnapshot = await _firestore.collection('users').doc(user.uid).get();
      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;
        final roles = userData['roles'];
        if (roles.contains('Pengurus')) {
          _isPengurus = true;
          update();
        }
      }
    }
  }

  void createPost() {
    Get.to(() =>  CreatePostView())?.then((value) {
      // Refresh page after creating a post
      update();
    });
  }
}
