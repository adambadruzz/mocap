import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatViewModel {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String message) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final timestamp = DateTime.now();

    await _firebaseFirestore.collection('chat_messages').add({
      'senderId': currentUser?.uid,
      'message': message,
      'timestamp': timestamp,
    });
  }

  Stream<QuerySnapshot> getChatMessages() {
    return _firebaseFirestore.collection('chat_messages').orderBy('timestamp', descending: true).snapshots();
  }
}
