import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mocap/view/registergugleview.dart';
import 'package:mocap/viewmodel/registergugle_viewmodel.dart';

import '../services/auth_service.dart';
import '../view/auth_view.dart';

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
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
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
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
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
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      final isRegistered = await authService.checkGoogleUserRegistration();
      Navigator.pop(context);

      if (isRegistered) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterGoogleView(
              viewModel: RegisterGoogleViewModel(authService: AuthService()),
            ),
          ),
        );
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
