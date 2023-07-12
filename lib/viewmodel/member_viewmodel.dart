import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/member_model.dart';

class MemberViewModel {
  final user = FirebaseAuth.instance.currentUser!;

  Future<List<MemberModel>> getMembersByRole(String role) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: role)
        .get();

    final members = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      // Convert Timestamp to DateTime
      final dobTimestamp = data['dob'] as Timestamp;
      final dob = dobTimestamp.toDate();

      return MemberModel(
        id: doc.id,
        name: data['name'],
        email: data['email'],
        dob: dob,
        phone: data['phone'],
        role: data['role'],
        photourl: data['photourl'],
        asal: data['asal'],
        angkatan: data['angkatan'],
        instagram: data['instagram'],
        github: data['github'],
        linkedin: data['linkedin'],
      );
    }).toList();

    return members;
  }
}
