import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateProfileViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      final userSnapshot = await _firestore.collection('users').doc(user?.uid).get();
      final userData = userSnapshot.data();

      return userData ?? {};
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<void> updateProfile(Map<String, dynamic> updatedUserDetails) async {
    try {
      final User? user = _firebaseAuth.currentUser;
      await _firestore.collection('users').doc(user?.uid).update(updatedUserDetails);
    } catch (e) {
      print('Error: $e');
      throw 'An error occurred while updating the profile.';
    }
  }

  Future<String> uploadProfilePhoto(File imageFile) async {
    try {
      final User? user = _firebaseAuth.currentUser;
      final ref = FirebaseStorage.instance.ref().child('profile_images/${user?.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = ref.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading profile photo: $e');
      throw 'An error occurred while uploading the profile photo.';
    }
  }

  Future<String?> getProfilePhotoUrl() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      final userSnapshot = await _firestore.collection('users').doc(user?.uid).get();
      final userData = userSnapshot.data();

      return userData?['photourl'] as String?;
    } catch (e) {
      print('Error getting profile photo URL: $e');
      return null;
    }
  }
}
