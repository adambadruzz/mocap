import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mocap/services/auth_service.dart';

import '../view/home_view.dart';

class RegisterViewModel {
  final AuthService authService;

  RegisterViewModel({required this.authService});

  
  void signUp({
    required String email,
    required String password,
    required String confirmpassword,
    required String nameController,
    required String phoneController,
    required DateTime selectedDate,
    
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      if (password == confirmpassword) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        //add user detail
        await authService.adduserdetail(
          name: nameController,
          phone: phoneController,
          dob: selectedDate,
          photourl: '11111',
          role: 'member',
          email: email,
        );
        Navigator.pop(context);
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );

      } else {
        Navigator.pop(context);
        showErrorMessage(context, 'Password and Confirm Password must be same');
      
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
