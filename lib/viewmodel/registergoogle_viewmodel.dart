import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocap/services/auth_service.dart';
import 'package:mocap/view/auth_view.dart';


class RegisterGoogleViewModel {
  final AuthService authService;

  RegisterGoogleViewModel({required this.authService});

  Future<void> signInWithGoogle(
    {
    required String angkatan,
    required String asal,
    required String instagram,
    required String github,
    required String linkedin,
    required DateTime selectedDate,
    required File? profileImage,
    required BuildContext context,
  }
  ) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    String profileImageUrl = '';
        if (profileImage != null) {
          profileImageUrl =
              await authService.uploadImageToFirebase(profileImage);
        }
        
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  
  if (googleUser != null) {
    final userData = await authService.getUserDataFromGoogle(googleUser);
    final email = userData['email'] as String?;
    final phoneNumber = userData['phoneNumber'] as String?;
    final fullName = userData['fullName'] as String?;

    final int tahun = DateTime.now().year;
    final int tahun2 = tahun + 1;


    await authService.adduserdetail(
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
    );

    Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthPage()),
        );
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
