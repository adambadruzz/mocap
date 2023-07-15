import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mocap/view/coursemenu_view.dart';
import 'package:mocap/view/event_view.dart';
import 'package:mocap/view/member_view.dart';
import 'package:mocap/view/pengurusmenu_view.dart';

import 'coursemenu_viewmodel.dart';

class HomeViewModel {
  final BuildContext context;

  HomeViewModel({required this.context});

  Future<bool> shouldShowCoursesMenu() {
  // Ambil data pengguna dari Firestore
  final currentUser = FirebaseAuth.instance.currentUser;
  final userRef = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid);
  
  return userRef.get().then((snapshot) {
    if (snapshot.exists) {
      final userData = snapshot.data() as Map<String, dynamic>;
      final roles = userData['roles'];
      
      // Cek apakah pengguna memiliki roles 'Pengurus' atau 'Member'
      if (roles.contains('Pengurus') || roles.contains('Member')) {
        return true;
      }
    }
    
    return false;
  }).catchError((error) {
    // Tangani jika terjadi error saat mengambil data dari Firestore
    print('Error: $error');
    return false;
  });
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
}
