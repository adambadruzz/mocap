import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/member_model.dart';

class MemberViewModel {
  final user = FirebaseAuth.instance.currentUser!;

  //untuk pengurus selanjutnya ganti String role, int tahun menjadi String role, int tahun2
  Future<List<MemberModel>> getMembersByRole(String role, int tahun) async {
    tahun = tahun + 1;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: role)
        .where('tahunkepengurusan', arrayContainsAny: [tahun]).get();

    final members = snapshot.docs.map((doc) {
      final data = doc.data();
      final tahunkepengurusan =
          (data['tahunkepengurusan'] as List<dynamic>).cast<int>();

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
        roles: data['role'],
        photourl: data['photourl'],
        asal: data['asal'],
        angkatan: data['angkatan'],
        tahunkepengurusan: tahunkepengurusan,
        instagram: data['instagram'],
        github: data['github'],
        linkedin: data['linkedin'],
      );
    }).toList();

    return members;
  }
}
