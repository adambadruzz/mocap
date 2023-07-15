import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostModel {
  final String id; // Tambahkan field 'id' pada model
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String title;
  final String description;
  final List<String> images;

  PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Tambahkan 'id' ke dalam map
      'title': title,
      'description': description,
      'images': images,
    };
  }

  factory PostModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final List<dynamic>? imageList = data['images'];

    return PostModel(
      id: snapshot.id, // Assign 'id' dari snapshot
      title: data['title'],
      description: data['description'],
      images: imageList?.cast<String>() ?? [],
    );
  }

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
