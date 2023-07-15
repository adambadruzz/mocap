import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import '../viewmodel/navbar_viewmodel.dart';
import 'navbar_view.dart';

class DetailEventView extends StatelessWidget {
  final PostModel post;
  final NavigationBarViewModel _navBarViewModel = NavigationBarViewModel();

  DetailEventView({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.images.isNotEmpty)
              Container(
                height: 200,
                width: double.infinity,
                child: PageView.builder(
                  itemCount: post.images.length,
                  itemBuilder: (context, index) {
                    final imageUrl = post.images[index];
                    return Image.network(imageUrl);
                  },
                ),
              ),
              const SizedBox(height: 16),
            Text(
              'Title:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(post.title),

            const SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(post.description),
          ],
        ),
      ),
      
    );
  }
}
