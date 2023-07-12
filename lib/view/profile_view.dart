import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';
import '../viewmodel/login_viewmodel.dart';
import '../viewmodel/navbar_viewmodel.dart';
import '../viewmodel/profile_viewmodel.dart';
import 'login_view.dart';
import 'navbar_view.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  final NavigationBarViewModel _navBarViewModel = NavigationBarViewModel();

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

  void _logout() {
    _profileViewModel.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginView(
          viewModel: LoginViewModel(authService: AuthService()),
        ),
      ),
    );
  }

  void _updateProfile() {
    // Add your logic here for updating the profile
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        
      ),
      body: DefaultTabController(
        length: 3, // Update the length to 3 for the additional tab
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.green.shade700,
                tabs: [
                  Tab(text: 'Information'),
                  Tab(text: 'Social Media'),
                  Tab(text: 'Settings'), // Add the new tab for settings
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Existing code for 'Information' tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Existing code for 'Information' tab
                          // ...
                        ],
                      ),
                    ),
                  ),
                  // Existing code for 'Social Media' tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Existing code for 'Social Media' tab
                          // ...
                        ],
                      ),
                    ),
                  ),
                  // New code for 'Settings' tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('Logout'),
                            onTap: _logout,
                          ),
                          ListTile(
                            leading: Icon(Icons.update),
                            title: Text('Update'),
                            onTap: _updateProfile,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBarView(
        viewModel: _navBarViewModel,
      ),
    );
  }
}
