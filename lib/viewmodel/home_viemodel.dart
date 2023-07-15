import 'package:flutter/material.dart';
import 'package:mocap/view/coursemenu_view.dart';
import 'package:mocap/view/event_view.dart';
import 'package:mocap/view/member_view.dart';
import 'package:mocap/view/pengurusmenu_view.dart';

import 'coursemenu_viewmodel.dart';

class HomeViewModel {
  final BuildContext context;

  HomeViewModel({required this.context});

  void navigateToEvent() {
   Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const EventView()),
    );
  }

  void navigateToMembers() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MemberView()),
    );
  }

  void navigateToCourses() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  CourseMenuView(viewModel: CourseMenuViewModel(context: context))));
  }

  void navigateToStructure() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PengurusMenuView()),
    );
  }
}
