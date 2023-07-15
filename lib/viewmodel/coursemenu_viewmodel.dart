import 'package:flutter/material.dart';
import 'package:mocap/view/course_view.dart';

class CourseMenuViewModel {
  final BuildContext context;

  CourseMenuViewModel({required this.context});

  void navigateToJava() {
   Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CourseView(courseType: 'Java',)),
    );
  }

  void navigateToKotlin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CourseView(courseType: 'Kotlin',)),
    );
  }

  void navigateToFlutter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CourseView(courseType: 'Flutter',)),
    );
  }

  void navigateToJS() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CourseView(courseType: 'Java Script',)),
    );
  }
}
