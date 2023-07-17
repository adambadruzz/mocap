import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:mocap/viewmodel/chat_viewmodel.dart';
import 'package:mocap/viewmodel/navbar_viewmodel.dart';

import 'navbar_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatViewModel _chatViewModel = ChatViewModel();
  final TextEditingController _messageController = TextEditingController();
  final NavigationBarViewModel _navBarViewModel = NavigationBarViewModel();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }

  Future<void> _initializeFirebaseMessaging() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _firebaseMessaging.getToken();
      print('Firebase Messaging Token: $token');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('onMessage: $message');
        // Lakukan penanganan notifikasi di sini
        _handleNotification(message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('onMessageOpenedApp: $message');
        // Lakukan tindakan berdasarkan pesan yang diterima saat aplikasi dibuka dari notifikasi
        _handleNotification(message);
      });
    }
  }

  void _handleNotification(RemoteMessage message) {
    // Menampilkan notifikasi atau melakukan tindakan berdasarkan pesan yang diterima saat aplikasi berjalan
    final Map<String, dynamic> notificationData = message.data;

    final String senderName = notificationData['senderName'];
    final String messageText = notificationData['message'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Message from $senderName'),
          content: Text(messageText),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Arahkan ke halaman ChatView
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatView()));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Peringatan'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendMessage(String message) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    // Cek apakah pengguna memiliki roles 'Pengurus' atau 'Member'
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .get();
    final roles = userDoc['roles'];
    if (!roles.contains('Pengurus') && !roles.contains('Member')) {
      _showAlertDialog(context, 'Anda tidak bisa mengirim pesan');
      return;
    }

    await _chatViewModel.sendMessage(message);
    // Panggil metode _sendNotification setelah mengirim pesan
    await _chatViewModel.sendNotification(currentUser!.uid, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _chatViewModel.getChatMessages(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<DocumentSnapshot> messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = messages[index].data() as Map<String, dynamic>;
                    final String messageId = messages[index].id;
                    final String senderId = message['senderId'];
                    final String messageText = message['message'];
                    final bool isCurrentUser = senderId == FirebaseAuth.instance.currentUser!.uid;

                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance.collection('users').doc(senderId).get(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          final userData = snapshot.data!.data() as Map<String, dynamic>;
                          final String userName = userData['name'];
                          final String userPhotoUrl = userData['photourl'];

                          return Dismissible(
                            key: Key(messageId),
                            direction: isCurrentUser ? DismissDirection.endToStart : DismissDirection.none,
                            onDismissed: (direction) {
                              if (isCurrentUser) {
                                _chatViewModel.deleteMessage(messageId);
                              }
                            },
                            background: isCurrentUser
                                ? Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : null,
                            child: Container(
                              alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                              child: ListTile(
                                leading: !isCurrentUser
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(userPhotoUrl),
                                      )
                                    : null,
                                title: Text(userName),
                                subtitle: Text(messageText),
                                trailing: isCurrentUser
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(userPhotoUrl),
                                      )
                                    : null,
                              ),
                            ),
                          );
                        }

                        return const ListTile(
                          title: Text('Loading...'),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final String message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                      _messageController.clear();
                    }
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBarView(
        viewModel: _navBarViewModel,
      ),
    );
  }
}
