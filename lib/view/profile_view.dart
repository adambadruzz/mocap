import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../viewmodel/drawer_viewmodel.dart';
import '../viewmodel/profile_viewmodel.dart';
import 'drawer_view.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  Map<String, dynamic> _userDetails = {};

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    final userDetails = await _profileViewModel.getCurrentUser();
    setState(() {
      _userDetails = userDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    final drawerViewModel = DrawerViewModel(
      authService: AuthService(),
      context: context,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: DrawerView(viewModel: drawerViewModel),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${_userDetails['name'] ?? 'Loading...'}'),
            Text('Email: ${_userDetails['email'] ?? 'Loading...'}'),
            Text('Date of Birth: ${_userDetails['dob'] ?? 'Loading...'}'),
            Text('Phone: ${_userDetails['phone'] ?? 'Loading...'}'),
            Text('Role: ${_userDetails['role'] ?? 'Loading...'}'),
          ],
        ),
      ),
    );
  }
}
