import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';
import 'package:mocap/view/event_view.dart';
import 'package:mocap/view/home_view.dart';
import 'package:mocap/view/profile_view.dart';
import 'package:mocap/viewmodel/home_viemodel.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: PersistentTabController(),
      backgroundColor: Colors.white,
      navBarStyle: NavBarStyle.style9,
      screens: [
        HomeView(viewModel: HomeViewModel(context: context)),
        const EventView(),
        const ProfileView()
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_rounded),
          title: "Home",
          activeColorPrimary: blueFigma,
          inactiveColorPrimary: greyFigma.withOpacity(0.4),
          textStyle: const TextStyle(color: Colors.white),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.auto_awesome_mosaic_rounded),
          title: "Post",
          activeColorPrimary: blueFigma,
          inactiveColorPrimary: greyFigma.withOpacity(0.4),
          textStyle: const TextStyle(color: Colors.white),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: "Profile",
          activeColorPrimary: blueFigma,
          inactiveColorPrimary: greyFigma.withOpacity(0.4),
          textStyle: const TextStyle(color: Colors.white),
        ),
      ],
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
    );
  }
}
