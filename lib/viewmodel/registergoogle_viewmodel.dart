import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocap/services/auth_service.dart';
import 'package:mocap/view/auth_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RegisterGoogleViewModel extends GetxController {
  final AuthService _authService = Get.find();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String selectedYear = '';

  List<String> get yearList {
    final int currentYear = DateTime.now().year;
    return List<String>.generate(10, (index) => (currentYear - index).toString());
  }

  Future<void> setSelectedYear(String year) async {
  selectedYear = year;
}


  Future<void> signInWithGoogle({
    required String angkatan,
    required String asal,
    required String instagram,
    required String github,
    required String linkedin,
    required DateTime selectedDate,
    required File? profileImage,

  }) async {
    showDialog(
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ), context: Get.overlayContext!,
    );

    try {
      String profileImageUrl = '';
      if (profileImage != null) {
        profileImageUrl = await _authService.uploadImageToFirebase(profileImage);
      }

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final fcmToken = await _firebaseMessaging.getToken();

        final userData = await _authService.getUserDataFromGoogle(googleUser);
        final email = userData['email'] as String?;
        final phoneNumber = userData['phoneNumber'] as String?;
        final fullName = userData['fullName'] as String?;

        final int tahun = DateTime.now().year;
        final int tahun2 = tahun + 1;

        await _authService.adduserdetail(
          access: 'Denied',
          name: fullName ?? 'Not Available',
          email: email ?? 'Not Available',
          phone: phoneNumber ?? 'Not Available',
          dob: selectedDate,
          photourl: profileImageUrl,
          role: 'Member',
          roles: 'Member',
          angkatan: angkatan,
          tahunkepengurusan: [tahun2],
          asal: asal,
          instagram: instagram,
          github: github,
          linkedin: linkedin,
          whatsapp: phoneNumber ?? 'Not Available',
          fcmToken: fcmToken,
        );

        Get.offAll(() => AuthPage());
      }
    } catch (e) {
      Get.back();
      showErrorMessage('Failed to sign in with Google');
    }
  }

  void showErrorMessage(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
