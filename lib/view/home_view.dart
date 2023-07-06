import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../viewmodel/drawer_viewmodel.dart';
import 'drawer_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    final drawerViewModel = DrawerViewModel(
      authService: AuthService(), // Ganti dengan instance AuthService yang sesuai
      context: context,
    );
    return Scaffold(
      appBar: AppBar(
        
      ),
      drawer: DrawerView(viewModel: drawerViewModel),
      body: Center(
        child: Text('Halo ${FirebaseAuth.instance.currentUser!.email}'),
      )
    );
  }
}