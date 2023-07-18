import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_model.dart';

class CreateCourseViewModel extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _title;
  late String _description;
  late String _youtubeLink;
  late String _selectedLevel;
  late String _selectedProgrammingLanguage;

  void setTitle(String value) {
    _title = value;
  }

  void setDescription(String value) {
    _description = value;
  }

  void setYoutubeLink(String value) {
    _youtubeLink = value;
  }

  void setSelectedLevel(String value) {
    _selectedLevel = value;
  }

  void setSelectedProgrammingLanguage(String value) {
    _selectedProgrammingLanguage = value;
  }

  void createCourse(String selectedLevel, String selectedLanguage) async {
    try {
      final collection = _firestore.collection(selectedLanguage);

      final index = await collection.get().then((snapshot) => snapshot.docs.length);

      final course = CourseModel(
        id: '',
        title: _title,
        description: _description,
        tingkatan: selectedLevel,
        linkYoutube: _youtubeLink,
        index: index,
      );

      await collection.add(course.toMap());

      Get.dialog(
        AlertDialog(
          title: Text('Success'),
          content: Text('Course created successfully'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      );

      _title = '';
      _description = '';
      _youtubeLink = '';
      _selectedLevel = 'Beginner';
      _selectedProgrammingLanguage = 'Flutter';

    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: Text('Error'),
          content: Text('Failed to create course'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    }
  }
}
