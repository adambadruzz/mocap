import 'package:flutter/material.dart';
import 'package:mocap/services/auth_service.dart';
import 'package:mocap/view/home_view.dart';
import 'package:mocap/view/login_view.dart';
import 'package:mocap/view/member_view.dart';
import 'package:mocap/view/profile_view.dart';
import 'package:mocap/viewmodel/profile_viewmodel.dart';

import 'login_viewmodel.dart';

class DrawerViewModel {
  final AuthService authService;
  final BuildContext context;

  DrawerViewModel({required this.authService, required this.context});

  void navigateToHomes() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
  }

  void navigateToProfile(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
  }

  void navigateToEvent() {
      
  }

  void navigateToCourses() {
      
  }

  void navigateToMembers() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MemberView()),
      );
  }

  void navigateToSettings() {
    
  }

  void navigateToUpdates() {
    
  }

  void logout() {
    authService.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView(viewModel: LoginViewModel(authService: AuthService()))),
      );
  }
}
