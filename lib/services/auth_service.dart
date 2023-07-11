import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
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

  Future<String> uploadImageToFirebase(File imageFile) async {
  try {
    final String userId = _firebaseAuth.currentUser!.uid;
    final String fileName = 'profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
    final UploadTask uploadTask = storageRef.putFile(imageFile);
    final TaskSnapshot storageSnapshot = await uploadTask;
    final String downloadUrl = await storageSnapshot.ref.getDownloadURL();

    return downloadUrl;
  } catch (e) {
    // Handle any errors during the upload process
    print('Error uploading image to Firebase: $e');
    throw e;
  }
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
  await _firebasefirestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
    {
      'access': access,
      'email': email,
      'name': name,
      'role': role,
      'phone': phone,
      'dob': dob,
      'photourl': photourl,
    }
  );
}


  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
