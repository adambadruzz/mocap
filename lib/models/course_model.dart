import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  final String id;
  final String title;
  final String linkYoutube;
  final String tingkatan;
  final String description;
  final int index;

  CourseModel({
    required this.id,
    required this.title,
    required this.linkYoutube,
    required this.tingkatan,
    required this.description,
    required this.index,
  });

  factory CourseModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CourseModel(
      id: snapshot.id,
      title: data['title'],
      linkYoutube: data['linkyoutube'],
      tingkatan: data['tingkatan'],
      description: data['description'],
      index: data['index'],
    );
  }
}
