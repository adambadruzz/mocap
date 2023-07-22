import 'package:flutter/material.dart';
import 'package:mocap/viewmodel/navbar_viewmodel.dart';

class NavBarView extends StatelessWidget {
  final NavigationBarViewModel viewModel;

  const NavBarView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: viewModel.currentIndex,
      onTap: (index) {
        viewModel.onTabSelected(index, context);
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
