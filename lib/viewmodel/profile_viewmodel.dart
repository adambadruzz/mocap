import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileViewModel extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rx<Map<String, dynamic>> userDetails = Rx<Map<String, dynamic>>({});

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user != null) {
        final DocumentSnapshot snapshot = await _firestore.collection('users').doc(user.uid).get();
        userDetails.value = snapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void logout() async {
    await _firebaseAuth.signOut();
    Get.offAllNamed('/login');
  }

  Future<void> _reauthenticateUser(String password) async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user != null) {
        final credential = EmailAuthProvider.credential(email: user.email!, password: password);
        await user.reauthenticateWithCredential(credential);
      }
    } catch (e) {
      print('Error: $e');
      throw 'Failed to reauthenticate user';
    }
  }

  Future<void> deleteAccount() async {
    final User? user = _firebaseAuth.currentUser;
    final uid = user?.uid;
    if (uid != null) {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser?.providerData.any((info) => info.providerId == 'google.com') == true) {
        try {
          await googleSignIn.disconnect();
          await currentUser?.delete();
          print('Google account disconnected and Firebase Auth account deleted.');
        } catch (e) {
          print('Failed to disconnect Google account: $e');
        }
      } else {
        print('User did not sign in with Google account.');
      }

      try {
        final String? photoUrl = userDetails.value['photourl'];
        if (photoUrl != null) {
          await FirebaseStorage.instance.refFromURL(photoUrl).delete();
        }
        await _firestore.collection('users').doc(uid).delete();
        await user?.delete();
      } catch (e) {
        print('Error: $e');
        throw 'Failed to delete account';
      }
      logout();
    }
  }
}
