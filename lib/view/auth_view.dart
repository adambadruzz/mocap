import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mocap/view/login_view.dart';
import '../services/auth_service.dart';
import 'home_view.dart';
import '../viewmodel/login_viewmodel.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginView(viewModel: LoginViewModel(authService: AuthService()));
        }
      },
    ));
  }
}
