import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/post_model.dart';
import 'createpost_view.dart';
import 'detailevent_view.dart';
import '../viewmodel/event_viewmodel.dart';

class EventView extends GetWidget<EventViewModel> {
  const EventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event'),
      ),
      body: StreamBuilder<List<PostModel>>(
        stream: controller.getPostsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.title),
                  leading: post.images.isNotEmpty ? Image.network(post.images[0]) : null,
                  onTap: () {
                    Get.to(() => DetailEventView(post: post));
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: controller.isPengurus
          ? FloatingActionButton(
              onPressed: () {
                controller.createPost();
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
