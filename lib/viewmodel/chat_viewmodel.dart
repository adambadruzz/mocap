// chatviewmodel.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatViewModel {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> sendMessage(String message) async {
    final currentUser = _firebaseAuth.currentUser;
    final timestamp = DateTime.now();

    await _firebaseFirestore.collection('chat_messages').add({
      'senderId': currentUser?.uid,
      'message': message,
      'timestamp': timestamp,
      'archived': false, // Set archived status to false
    });
  }

  Future<void> deleteMessage(String messageId) async {
    await _firebaseFirestore.collection('chat_messages').doc(messageId).delete();
  }

  Stream<QuerySnapshot> getChatMessages() {
    return _firebaseFirestore.collection('chat_messages').orderBy('timestamp', descending: true).snapshots();
  }
}
