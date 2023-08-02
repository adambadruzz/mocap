import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../viewmodel/access_viewmodel.dart';

class AccessView extends StatelessWidget {
  final AccessViewModel viewModel;

  AccessView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Access'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: viewModel.getDeniedUsers(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final users = snapshot.data?.docs ?? [];

          if (users.isEmpty) {
            return const Center(
              child: Text('No users with denied access.'),
            );
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              final userData = users[index].data() as Map<String, dynamic>;
              final name = userData['name'] ?? '';
              final email = userData['email'] ?? '';

              return ListTile(
                title: Text(name),
                subtitle: Text(email),
                trailing: ElevatedButton(
                  onPressed: () {
                    viewModel.approveAccess(users[index].id);
                  },
                  child: const Text('Approve'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
