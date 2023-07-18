import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthViewModel extends GetxController {
  Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  RxBool _isLoading = RxBool(true);
  bool get isLoading => _isLoading.value;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      _user.value = user;
      _isLoading.value = false;
    });
  }

  Future<String?> getUserAccess() async {
    if (user != null) {
      final userSnapshot =
          await _firebaseFirestore.collection('users').doc(user!.uid).get();
      final access = userSnapshot.get('access') as String?;
      return access;
    }
    return null;
  }
}
