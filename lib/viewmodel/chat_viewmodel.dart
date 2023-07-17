import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatViewModel {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> sendMessage(String message) async {
    final currentUser = _firebaseAuth.currentUser;
    final timestamp = DateTime.now();

    await _firebaseFirestore.collection('chat_messages').add({
      'senderId': currentUser?.uid,
      'message': message,
      'timestamp': timestamp,
    });

    // Kirim notifikasi kepada pengguna lain
    await sendNotification(currentUser!.uid, message);
  }

  Future<void> deleteMessage(String messageId) async {
    await _firebaseFirestore.collection('chat_messages').doc(messageId).delete();
  }

  Stream<QuerySnapshot> getChatMessages() {
    return _firebaseFirestore
        .collection('chat_messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> sendNotification(String senderId, String message) async {
    final querySnapshot = await _firebaseFirestore
        .collection('users')
        .where(FieldPath.documentId, isNotEqualTo: senderId)
        .get();

    final List<String> recipientTokens = [];

    querySnapshot.docs.forEach((doc) {
      final recipientToken = doc['fcmToken'];
      if (recipientToken != null) {
        recipientTokens.add(recipientToken);
      }
    });

    final currentUser = _firebaseAuth.currentUser;
    final currentUserDoc = await _firebaseFirestore
        .collection('users')
        .doc(currentUser?.uid)
        .get();

    final senderName = currentUserDoc['name'];

    final messageData = <String, String>{
      'senderName': senderName,
      'message': message,
    };

    for (final token in recipientTokens) {
      await _firebaseMessaging.sendMessage(
        to: token,
        data: messageData,
      );
    }
  }
}
