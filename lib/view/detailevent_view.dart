import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/post_model.dart';
import '../viewmodel/detailevent_viewmodel.dart';

class DetailEventView extends StatelessWidget {
  final PostModel post;

  DetailEventView({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailEventViewModel>(
      init: DetailEventViewModel(post: post),
      builder: (viewModel) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Obx(() {
                if (viewModel.hasSpecialRole.value) {
                  return IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      viewModel.showConfirmationDialog(context);
                    },
                  );
                }
                return const SizedBox();
              }),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post.images.isNotEmpty)
                  SizedBox(
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
                const Text(
                  'Title:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(post.title),
                const SizedBox(height: 16),
                const Text(
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
      },
    );
  }
}
