import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/member_model.dart';

class MemberViewModel extends GetxController {
  final user = FirebaseAuth.instance.currentUser!;
  final RxList<MemberModel> leaders = <MemberModel>[].obs;
  final RxList<MemberModel> coleaders = <MemberModel>[].obs;
  // Tambahkan RxList dan variabel lainnya sesuai dengan role yang diinginkan

  @override
  void onInit() {
    super.onInit();
    _fetchMembers();
  }

  Future<void> _fetchMembers() async {
    final int tahun = DateTime.now().year;
    // Untuk pengurus selanjutnya
    final leadersResult = await getMembersByRole('Leader', tahun);
    final coleadersResult = await getMembersByRole('Co-Leader', tahun);
    // Tambahkan pemanggilan fungsi dan variabel lainnya sesuai dengan role yang diinginkan

    leaders.value = leadersResult;
    coleaders.value = coleadersResult;
    // Tambahkan pemanggilan variabel lainnya sesuai dengan role yang diinginkan
  }

  Future<List<MemberModel>> getMembersByRole(String role, int tahun) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: role)
        .where('tahunkepengurusan', arrayContainsAny: [tahun])
        .get();

    final members = snapshot.docs.map((doc) {
      final data = doc.data();
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
