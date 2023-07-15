
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MemberModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String id;
  final String name;
  final String email;
  final DateTime dob;
  final String asal;
  final String phone;
  final String role;
  final String roles;
  final String angkatan;
  final List<int> tahunkepengurusan;
  final String photourl;
  final String instagram;
  final String github;
  final String linkedin;

  MemberModel({
    required this.id,
    required this.name,
    required this.email,
    required this.dob,
    required this.phone,
    required this.role,
    required this.roles,
    required this.asal,
    required this.angkatan,
    required this.tahunkepengurusan,
    required this.photourl,
    required this.instagram,
    required this.github,
    required this.linkedin,
  });

  Future<bool> hasSpecialRole() async {
  final currentUserData = await getCurrentUser();
  if (currentUserData['specialrole'] == 'admin') {
    return true;
  } else {
    return false;
  }
}

Future<Map<String, dynamic>> getCurrentUser() async {
  try {
    final User? user = _firebaseAuth.currentUser;
    if (user != null) {
      final DocumentSnapshot snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
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