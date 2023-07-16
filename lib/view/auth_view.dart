import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mocap/view/login_view.dart';
import 'package:mocap/view/register_view.dart';
import '../services/auth_service.dart';
import '../viewmodel/home_viemodel.dart';
import '../viewmodel/register_viewmodel.dart';
import 'home_view.dart';
import '../viewmodel/login_viewmodel.dart';
import 'waiting_view.dart'; // Import waiting_view.dart

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data != null) {
                  final access = snapshot.data!.get('access') as String?;
                  if (access == null) {
                    // User access is null, navigate to register view
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => RegisterView(viewModel: RegisterViewModel(authService: AuthService()))),
                      );
                    });
                    return Container();
                  } else if (access == 'Denied' || access == 'Granted' || access == 'Pending' || access == 'OK' || access == 'Approved') {
                    // Show waiting view if access is denied, granted, pending, or OK
                    return const WaitingView();
                  } else {
                    // User has valid access, navigate to home view
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                     Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeView(viewModel: HomeViewModel(context: context)),
                        ),
                      );
                    });
                    return Container();
                  }
                } else {
                  return const SizedBox();
                }
              },
            );
          } else {
            // User is not logged in, navigate to login view
            return LoginView(viewModel: LoginViewModel(authService: AuthService()));
          }
        },
      ),
    );
  }
}