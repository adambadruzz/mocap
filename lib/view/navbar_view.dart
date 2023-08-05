import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';
import 'package:mocap/view/event_view.dart';
import 'package:mocap/view/home_view.dart';
import 'package:mocap/view/profile_view.dart';
import 'package:mocap/viewmodel/home_viemodel.dart';

class NavBarView extends StatefulWidget {
  // final NavigationBarViewModel viewModel;

  const NavBarView({Key? key}) : super(key: key);

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
     List<Widget> screens = [
      HomeView(viewModel: HomeViewModel(context: context)),
      const EventView(),
      const ProfileView()
    ];
    
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: screens,
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) {
          // widget.viewModel.onTabSelected(index, context);
          setState(() {
            _selectedIndex = index;
            pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              activeColor: blueFigma,
              inactiveColor: greyFigma.withOpacity(0.4),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              icon: const Icon(Icons.auto_awesome_mosaic_rounded),
              title: const Text("Post"),
              activeColor: blueFigma,
              inactiveColor: greyFigma.withOpacity(0.4),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
              activeColor: blueFigma,
              inactiveColor: greyFigma.withOpacity(0.4),
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
