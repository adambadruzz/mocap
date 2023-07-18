import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocap/services/auth_service.dart';
import 'package:mocap/view/login_view.dart';



class ResetPasswordViewModel extends GetxController {
  final AuthService authService = Get.find();

  void resetPassword({
    required String email,
  }) async {
    try {
      await authService.resetPassword(email: email);
      Get.off(() => LoginView());
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
