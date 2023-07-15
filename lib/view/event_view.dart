import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import '../viewmodel/navbar_viewmodel.dart';
import 'createpost_view.dart';
import 'detailevent_view.dart';
import 'navbar_view.dart';

class EventView extends StatefulWidget {
  const EventView({Key? key}) : super(key: key);

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NavigationBarViewModel _navBarViewModel = NavigationBarViewModel();
  bool _isPengurus = false;

  @override
  void initState() {
    super.initState();
    _checkPengurusRole();
  }

  void _checkPengurusRole() async {
    final user = _auth.currentUser;
    if (user != null) {
      final docSnapshot = await _firestore.collection('users').doc(user.uid).get();
      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;
        final roles = userData['roles'];
        if (roles.contains('Pengurus')) {
          setState(() {
            _isPengurus = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final posts = snapshot.data!.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.title),
                  leading: post.images.isNotEmpty ? Image.network(post.images[0]) : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailEventView(post: post)),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: _isPengurus
          ? FloatingActionButton(
              onPressed: () {
                _createPost();
              },
              child: Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavBarView(
        viewModel: _navBarViewModel,
      ),
    );
  }

  void _createPost() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreatePostView()),
    ).then((value) {
      // Refresh page after creating a post
      setState(() {});
    });
  }
}
