import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../view/access_view.dart';
import '../view/coursemenu_view.dart';
import '../view/event_view.dart';
import '../view/member_view.dart';
import '../view/pengurusmenu_view.dart';


class HomeViewModel extends GetxController {


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
    Get.to(() => const EventView());
  }

  void navigateToMembers() {
    Get.to(() =>  MemberView());
  }

  void navigateToCourses() async {
    if (await shouldShowCoursesMenu()) {
      Get.to(() => CourseMenuView());
    }
  }

  void navigateToStructure() {
    Get.to(() => PengurusMenuView());
  }

  void navigateToAccess() {
    Get.to(() => AccessView());
  }
}
