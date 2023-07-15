import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String title;
  final String description;
  final List<String> images;

  PostModel({
    required this.title,
    required this.description,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'images': images,
    };
  }

  factory PostModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final List<dynamic>? imageList = data['images'];

    return PostModel(
      title: data['title'],
      description: data['description'],
      images: imageList?.cast<String>() ?? [],
    );
  }
}
