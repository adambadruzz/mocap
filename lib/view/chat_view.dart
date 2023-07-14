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

                          return Container(
                            alignment: senderId == currentUserUid ? Alignment.centerRight : Alignment.centerLeft,
                            child: ListTile(
                              leading: senderId != currentUserUid
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(userPhotoUrl),
                                    )
                                  : null,
                              title: Text(userName),
                              subtitle: Text(messageText),
                              trailing: senderId == currentUserUid
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(userPhotoUrl),
                                    )
                                  : null,
                            ),
                          );
                        }

                        return ListTile(
                          title: const Text('Loading...'),
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
