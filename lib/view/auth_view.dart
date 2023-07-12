import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mocap/view/login_view.dart';
import 'package:mocap/view/navbar_view.dart';
import '../services/auth_service.dart';
import '../viewmodel/home_viemodel.dart';
import 'home_view.dart';
import '../viewmodel/login_viewmodel.dart';
import 'waiting_view.dart'; // Import waiting_view.dart

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key); // Update the constructor with nullable key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), // Update the stream type
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return WaitingView(); // Show waiting view if still loading
          } else if (snapshot.hasData) {
            // User is logged in, check access
            final user = snapshot.data!;
            if (user != null) {
              return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null && snapshot.data!.exists) {
                    final access = snapshot.data!['access'] as String;
                    if (access == 'Denied' || access == 'Granted' || access == 'Pending' || access == 'OK') {
                      return WaitingView();
                      
                    } else {
                      return HomeView(viewModel: HomeViewModel(context: context)); // Navigate to home view if access is not denied
                    }
                  } else {
                    return WaitingView();
                  }
                },
              );
            }
          }
          // User is not logged in or access is denied
          return LoginView(viewModel: LoginViewModel(authService: AuthService()));
        },
      ),
    );
  }
}
