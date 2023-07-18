import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/navbar_viewmodel.dart';
import 'chat_view.dart';
import 'home_view.dart';
import 'profile_view.dart';

class NavBarView extends GetWidget<NavigationBarViewModel> {
  NavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        controller.onTabSelected(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
