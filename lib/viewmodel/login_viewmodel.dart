import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mocap/services/auth_service.dart';
import 'package:mocap/view/home_view.dart';
import 'package:mocap/view/login_view.dart';

class LoginViewModel {
  final AuthService authService;

  LoginViewModel({required this.authService});

  void signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(context, e.code);
    }
  }

  void signInWithGoogle() {
    authService.signInWithGoogle();
  }

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
