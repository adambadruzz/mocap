import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user != null) {
        final DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();
        return snapshot.data() as Map<String, dynamic>;
      }
      return {};
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  void signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> _reauthenticateUser(String password) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
      }
    } catch (e) {
      print('Error: $e');
      throw 'Failed to reauthenticate user';
    }
  }

  Future<void> deleteAccount(String password) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid;
    if (uid != null) {
      final GoogleSignIn googleSignIn = GoogleSignIn();
  final currentUser = FirebaseAuth.instance.currentUser;

  // Pastikan user sudah login menggunakan akun Google
  if (currentUser?.providerData.any((info) => info.providerId == 'google.com') == true) {
    try {
      await googleSignIn.disconnect();
      // Setelah berhasil memutuskan hubungan, Anda dapat menghapus akun Firebase Auth jika diperlukan
      await currentUser?.delete();
      print('Akun Google berhasil diputuskan hubungannya dan akun Firebase Auth dihapus.');
    } catch (e) {
      print('Gagal memutuskan hubungan akun Google: $e');
    }
  } else {
    print('User tidak login dengan akun Google.');
  }
      // Meminta pengguna memasukkan password
      try {
        // Melakukan otentikasi ulang pengguna
        await _reauthenticateUser(password);

        // Menghapus akun pengguna
        await FirebaseFirestore.instance.collection('users').doc(uid).delete();
        await user?.delete();

        // Menghapus gambar profil pengguna dari Firebase Storage
        final String? photoUrl = (await getCurrentUser())['photourl'];
        if (photoUrl != null) {
          await FirebaseStorage.instance.refFromURL(photoUrl).delete();
        }
      } catch (e) {
        print('Error: $e');
        throw 'Failed to delete account';
      }
    }
  }
}
