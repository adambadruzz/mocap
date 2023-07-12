import 'package:flutter/material.dart';
import 'package:mocap/view/member_view.dart';
import 'package:mocap/view/course_view.dart';

class HomeViewModel {
  final BuildContext context;

  HomeViewModel({required this.context});

  void navigateToEvent() {
   
  }

  void navigateToMembers() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MemberView()),
    );
  }

  void navigateToCourses() {
    
  }

  void navigateToStructure() {
    
  }
}
