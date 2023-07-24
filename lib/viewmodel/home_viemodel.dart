import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mocap/view/coursemenu_view.dart';
import 'package:mocap/view/event_view.dart';
import 'package:mocap/view/member_view.dart';
import 'package:mocap/view/pengurusmenu_view.dart';

import '../view/access_view.dart';
import 'access_viewmodel.dart';
import 'coursemenu_viewmodel.dart';

class HomeViewModel {
  final BuildContext context;

  HomeViewModel({required this.context});

  Future<bool> shouldShowCoursesMenu() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userRef = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid);

    try {
      final snapshot = await userRef.get();
      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        final roles = userData['roles'];

        if (roles.contains('Pengurus') || roles.contains('Member')) {
          return true;
        }
      }
    } catch (error) {
      print('Error: $error');
    }

    return false;
  }

  Future<bool> isUserAdmin() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
      final userSnapshot = await userDoc.get();
      final userData = userSnapshot.data();

      if (userData?['specialrole'] == 'admin') {
        return true;
      }
    }

    return false;
  }

  void navigateToEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EventView()),
    );
  }

  void navigateToMembers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MemberView()),
    );
  }

  void navigateToCourses() async {
    if (await shouldShowCoursesMenu()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CourseMenuView(viewModel: CourseMenuViewModel(context: context))),
      );
    }
  }

  void navigateToStructure() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PengurusMenuView()),
    );
  }

  void navigateToAccess() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccessView(viewModel: AccessViewModel())),
    );
  }
}
