import 'package:flutter/material.dart';
import 'package:mocap/view/course_view.dart';
import 'package:mocap/view/member_view.dart';
import 'package:mocap/view/pengurusmenu_view.dart';

class CourseMenuViewModel {
  final BuildContext context;

  CourseMenuViewModel({required this.context});

  void navigateToJava() {
   Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CourseView(courseType: 'Java',)),
    );
  }

  void navigateToKotlin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CourseView(courseType: 'Kotlin',)),
    );
  }

  void navigateToFlutter() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CourseView(courseType: 'Flutter',)),
    );
  }

  void navigateToJS() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CourseView(courseType: 'Java Script',)),
    );
  }
}
