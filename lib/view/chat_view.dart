import 'package:flutter/material.dart';
import '../viewmodel/navbar_viewmodel.dart';
import 'navbar_view.dart';

class ChatView extends StatelessWidget {
final NavigationBarViewModel _navBarViewModel = NavigationBarViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: Text('Chat UPDATE Page'),
      ),
      bottomNavigationBar: NavBarView(
        viewModel: _navBarViewModel,
      ),
    );
  }
}