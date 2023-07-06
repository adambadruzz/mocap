import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user != null) {
        final DocumentSnapshot snapshot = await _firestore
            .collection('users')
            .doc(user.email)
            .get();
        return snapshot.data() as Map<String, dynamic>;
      }
      return {};
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }
}
