
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);
  }

  Future<Map<String, dynamic>> getUserDataFromGoogle(GoogleSignInAccount googleUser) async {
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
  final User? user = userCredential.user;
  
  // Mengambil data email, nomor handphone, dan nama lengkap dari pengguna
  final email = user?.email;
  final phoneNumber = user?.phoneNumber;
  final fullName = user?.displayName;
  

  // Mengembalikan data dalam bentuk Map
  return {
    'email': email,
    'phoneNumber': phoneNumber,
    'fullName': fullName,
  };
}

Future<bool> checkGoogleUserRegistration() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  try {
    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    final User? user = userCredential.user;

    // Mengecek apakah pengguna terdaftar berdasarkan ID pengguna Google
    final DocumentSnapshot userSnapshot = await _firebasefirestore
        .collection('users')
        .doc(user!.uid)
        .get();

    return userSnapshot.exists;
  } catch (e) {
    print('Error checking Google user registration: $e');
    rethrow;
  }
}


  Future<String> uploadImageToFirebase(File imageFile) async {
  try {
    final String userId = _firebaseAuth.currentUser!.uid;
    final String fileName = 'profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
    final UploadTask uploadTask = storageRef.putFile(imageFile);
    final TaskSnapshot storageSnapshot = await uploadTask;
    final String downloadUrl = await storageSnapshot.ref.getDownloadURL();

    return downloadUrl;
  } catch (e) {
    // Handle any errors during the upload process
    print('Error uploading image to Firebase: $e');
    rethrow;
  }
}

  Future<void> adduserdetail({
  required String access,
  required String name,
  required String email,
  required DateTime dob,
  required String asal,
  required String phone,
  required String role,
  required String roles,
  required String angkatan,
  required List<int> tahunkepengurusan,
  required String photourl,
  required String instagram,
  required String github,
  required String linkedin,
}) async {
  await _firebasefirestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
    {
      'access': access,
      'email': email,
      'name': name,
      'role': role,
      'roles': roles,
      'phone': phone,
      'dob': dob,
      'photourl': photourl,
      'asal': asal,
      'angkatan': angkatan,
      'tahunkepengurusan': tahunkepengurusan,
      'instagram': instagram,
      'github': github,
      'linkedin': linkedin,
    },
  );
}


  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
