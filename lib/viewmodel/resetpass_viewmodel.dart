import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mocap/services/auth_service.dart';
import 'package:mocap/view/login_view.dart';

import 'login_viewmodel.dart';

class ResetPasswordViewModel {
  final AuthService authService;

  ResetPasswordViewModel({required this.authService});

  void resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await authService.resetPassword(
        email: email,
      );
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView(viewModel: LoginViewModel(authService: AuthService()))),
      );
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
