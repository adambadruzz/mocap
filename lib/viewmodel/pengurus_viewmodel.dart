import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocap/models/member_model.dart';

class PengurusViewModel {
  final user = FirebaseAuth.instance.currentUser!;

  Future<List<MemberModel>> getMembersByRole(String role, int tahunselesai) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('roles', isEqualTo: role)
        .where('tahunkepengurusan', arrayContainsAny: [tahunselesai])
        .get();

    final members = snapshot.docs.map((doc) {
      final data = doc.data();

      // Convert 'tahunkepengurusan' to List<int>
      final tahunkepengurusan = (data['tahunkepengurusan'] as List<dynamic>).cast<int>();

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
        roles: data['roles'],
        asal: data['asal'],
        angkatan: data['angkatan'],
        tahunkepengurusan: tahunkepengurusan,
        photourl: data['photourl'],
        instagram: data['instagram'],
        github: data['github'],
        linkedin: data['linkedin'],
      );
    }).toList();

    return members;
  }

  Future<List<MemberModel>> getMembersByRoleMember(String role, int tahunselesai) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('roles', isEqualTo: role)
        .where('tahunkepengurusan', arrayContainsAny: [tahunselesai])
        .get();

    final members = snapshot.docs.map((doc) {
      final data = doc.data();

      // Convert 'tahunkepengurusan' to List<int>
      final tahunkepengurusan = (data['tahunkepengurusan'] as List<dynamic>).cast<int>();

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
        roles: data['roles'],
        asal: data['asal'],
        angkatan: data['angkatan'],
        tahunkepengurusan: tahunkepengurusan,
        photourl: data['photourl'],
        instagram: data['instagram'],
        github: data['github'],
        linkedin: data['linkedin'],
      );
    }).toList();

    return members;
  }
}
