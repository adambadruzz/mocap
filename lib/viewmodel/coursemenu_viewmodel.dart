import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../view/course_view.dart';
import '../view/createcourse_view.dart';

class CourseMenuViewModel extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isAdmin() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final uid = user.uid;
      final userDoc = await _firestore.collection('users').doc(uid).get();
      final userData = userDoc.data() as Map<String, dynamic>;
      final specialRole = userData['specialrole'];
      return specialRole == 'admin';
    }
    return false;
  }

  void navigateToCourse(String courseType) {
    Get.to(() => CourseView(courseType: courseType));
  }

  Future<void> navigateToAddCourse(BuildContext context) async {
    final user = _firebaseAuth.currentUser;
    if (user != null && await isAdmin()) {
      Get.to(() => CreateCourseView());
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Unauthorized'),
            content: Text('You do not have permission to create a course.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
