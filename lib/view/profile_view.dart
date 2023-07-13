import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
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
    // Add your logic here to navigate to the login or home page
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
       
      ),
      body: DefaultTabController(
        length: 3, // Updated to include the new "Settings" tab
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
                  Tab(text: 'Settings'), // New "Settings" tab
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _userDetails['photourl'] != null
                                  ? CachedNetworkImageProvider(
                                      _userDetails['photourl']!,
                                    )
                                  : null,
                              child: _userDetails['photourl'] == null
                                  ? Icon(Icons.person, size: 50)
                                  : null,
                            ),
                          ),
                          SizedBox(height: 16),
                          Card(
                            child: ListTile(
                              title: Text('Name'),
                              subtitle: Text(
                                _userDetails['name'] ?? 'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text('Email'),
                              subtitle: Text(
                                _userDetails['email'] ?? 'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text('Date of Birth'),
                              subtitle: Text(
                                _formatDateOfBirth(_userDetails['dob']) ??
                                    'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text('Phone'),
                              subtitle: Text(
                                _userDetails['phone'] ?? 'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text('Role'),
                              subtitle: Text(
                                _userDetails['role'] ?? 'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text('Asal'),
                              subtitle: Text(
                                _userDetails['asal'] ?? 'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text('Angkatan'),
                              subtitle: Text(
                                _userDetails['angkatan'] ?? 'Loading...',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _userDetails['photourl'] != null
                                  ? CachedNetworkImageProvider(
                                      _userDetails['photourl']!,
                                    )
                                  : null,
                              child: _userDetails['photourl'] == null
                                  ? Icon(Icons.person, size: 50)
                                  : null,
                            ),
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/whatsapp.png',
                              width: 30,
                            ),
                            title: Text('Whatsapp'),
                            subtitle: Text(
                              _userDetails['phone'] ?? 'Not Available',
                            ),
                            onTap: () {
                              // Add your logic here to open Whatsapp profile
                            },
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/instagram.png',
                              width: 30,
                            ),
                            title: Text('Instagram'),
                            subtitle: Text(
                              _userDetails['instagram'] ?? 'Not Available',
                            ),
                            onTap: () {
                              // Add your logic here to open Instagram profile
                            },
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/linkedin.png',
                              width: 30,
                            ),
                            title: Text('Linkedin'),
                            subtitle: Text(
                              _userDetails['linkedin'] ?? 'Not Available',
                            ),
                            onTap: () {
                              // Add your logic here to open Linkedin profile
                            },
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/github.png',
                              width: 30,
                            ),
                            title: Text('Github'),
                            subtitle: Text(
                              _userDetails['github'] ?? 'Not Available',
                            ),
                            onTap: () {
                              
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('Logout'),
                            onTap: _logout,
                          ),
                          SizedBox(height: 16),
                          // ListTile(
                          //   leading: Icon(Icons.update),
                          //   title: Text('Update'),
                          //   onTap: ,
                          // ),
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

  String? _formatDateOfBirth(Timestamp? timestamp) {
    if (timestamp != null) {
      final dateTime = timestamp.toDate();
      final formatter = DateFormat('dd MMM yyyy');
      return formatter.format(dateTime);
    }
    return null;
  }
}
