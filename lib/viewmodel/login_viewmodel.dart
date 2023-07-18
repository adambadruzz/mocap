import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocap/viewmodel/registergoogle_viewmodel.dart';

import '../services/auth_service.dart';
import '../view/auth_view.dart';
import '../view/home_view.dart';
import '../view/registergoogle_view.dart';
import 'home_viemodel.dart';

class LoginViewModel extends GetxController {
  final AuthService authService;

  LoginViewModel({required this.authService});

  void signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pop(context);
      Get.offAll(() => AuthPage());
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(context, e.code);
    }
  }

  void signInGuest({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pop(context);
      Get.offAll(() => AuthPage());
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(context, e.code);
    }
  }

  void signInWithGoogle({
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      final isRegistered = await authService.checkGoogleUserRegistration();

      if (isRegistered) {
        Get.offAll(() => HomeView());
      } else {
        Get.offAll(() => RegisterGoogleView(
              
            ));
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(context, e.code);
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
