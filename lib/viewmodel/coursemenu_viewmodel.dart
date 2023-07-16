import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../view/course_view.dart';
import '../view/createcourse_view.dart';

class CourseMenuViewModel {
  final BuildContext context;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CourseMenuViewModel({required this.context});

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

  void navigateToJava() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CourseView(courseType: 'Java')),
    );
  }

  void navigateToKotlin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CourseView(courseType: 'Kotlin')),
    );
  }

  void navigateToFlutter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CourseView(courseType: 'Flutter')),
    );
  }

  void navigateToJS() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CourseView(courseType: 'JavaScript')),
    );
  }

  Future<void> navigateToAddCourse(BuildContext context) async {
    final user = _firebaseAuth.currentUser;
    if (user != null && await isAdmin()) { // Menunggu hasil dari isAdmin()
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateCourseView()),
      );
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
