import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mocap/viewmodel/chat_viewmodel.dart';

import '../viewmodel/navbar_viewmodel.dart';
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
                    final String senderId = message['senderId'];
                    final String messageText = message['message'];

                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance.collection('users').doc(senderId).get(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          final userData = snapshot.data!.data() as Map<String, dynamic>;
                          final String userName = userData['name'];
                          final String userPhotoUrl = userData['photourl'];
                          final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

                          if (senderId == currentUserUid) {
                            // Pesan pengguna yang dikirim (sebelah kanan)
                            return Container(
                              alignment: Alignment.centerRight,
                              child: ListTile(
                                title: Text(userName),
                                subtitle: Text(messageText),
                                trailing: CircleAvatar(
                                  backgroundImage: NetworkImage(userPhotoUrl),
                                ),
                              ),
                            );
                          } else {
                            // Pesan pengguna lain (sebelah kiri)
                            return Container(
                              alignment: Alignment.centerLeft,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(userPhotoUrl),
                                ),
                                title: Text(userName),
                                subtitle: Text(messageText),
                              ),
                            );
                          }
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
                      _chatViewModel.sendMessage(message);
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
