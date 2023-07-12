import 'package:flutter/material.dart';
import 'package:mocap/view/chat_view.dart';
import 'package:mocap/view/home_view.dart';
import 'package:mocap/viewmodel/home_viemodel.dart';

import '../view/profile_view.dart';

class NavigationBarViewModel {
  int currentIndex = 0;

  void onTabSelected(int index, BuildContext context) {
    currentIndex = index;

    // Navigasi berdasarkan tab yang dipilih
    switch (currentIndex) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeView(viewModel: HomeViewModel(context: context))),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatView()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileView()),
        );
        break;
    }
  }
}
