import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AccessViewModel extends GetxController {
  Stream<QuerySnapshot> getDeniedUsers() {
    final usersRef = FirebaseFirestore.instance.collection('users');

    return usersRef.where('access', isEqualTo: 'Denied').snapshots();
  }

  void approveAccess(String userId) {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    userRef.update({'access': 'mm'});
  }
}
