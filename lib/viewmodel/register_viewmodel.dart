import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocap/services/auth_service.dart';
import 'package:mocap/view/auth_view.dart';


class RegisterViewModel extends GetxController {
  final AuthService authService = Get.find();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmpassword,
    required String name,
    required String phone,
    required String angkatan,
    required String asal,
    required String instagram,
    required String github,
    required String linkedin,
    required DateTime selectedDate,
    required File? profileImage,
  }) async {
    try {
      if (password == confirmpassword) {
        final fcmToken = await _firebaseMessaging.getToken();

        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String profileImageUrl = '';
        if (profileImage != null) {
          profileImageUrl = await authService.uploadImageToFirebase(profileImage);
        }

        final int tahun = DateTime.now().year;
        final int tahun2 = tahun + 1;

        await authService.adduserdetail(
          access: 'Denied',
          name: name,
          phone: phone,
          dob: selectedDate,
          photourl: profileImageUrl,
          role: 'Member',
          roles: 'Member',
          email: email,
          angkatan: angkatan,
          tahunkepengurusan: [tahun2],
          asal: asal,
          instagram: instagram,
          github: github,
          linkedin: linkedin,
          whatsapp: phone,
          fcmToken: fcmToken,
        );

        Get.offAll(() => AuthPage());
      } else {
        showErrorMessage('Password and Confirm Password must be the same');
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);
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
