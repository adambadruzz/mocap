import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> adduserdetail(
  {
    required String name,
    required String phone,
    required DateTime dob,
    required String photourl,
    required String role,
    required String access,
    required String email
  }
) async {
  await _firebasefirestore.collection('users').doc(FirebaseAuth.instance.currentUser!.email).set(
    {
      'email': email,
      'name': name,
      'role': role,
      'phone': phone,
      'dob': dob,
      'access': access,
      'photourl': photourl,
    }
  );
}


  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
