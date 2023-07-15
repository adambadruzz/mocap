import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';
import '../viewmodel/login_viewmodel.dart';
import '../viewmodel/navbar_viewmodel.dart';
import '../viewmodel/profile_viewmodel.dart';
import 'login_view.dart';
import 'navbar_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

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

  Future<void> _launchUrl(String? url) async {
    if (await canLaunch(url!)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
                tabs: const [
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
                                  ? const Icon(Icons.person, size: 50)
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            child: ListTile(
                              title: const Text('Name'),
                              subtitle: Text(
                                _userDetails['name'] ?? 'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Email'),
                              subtitle: Text(
                                _userDetails['email'] ?? 'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Date of Birth'),
                              subtitle: Text(
                                _formatDateOfBirth(_userDetails['dob']) ??
                                    'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Phone'),
                              subtitle: Text(
                                _userDetails['phone'] ?? 'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Role'),
                              subtitle: Text(
                                _userDetails['role'] ?? 'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Asal'),
                              subtitle: Text(
                                _userDetails['asal'] ?? 'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Angkatan'),
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
                                  ? const Icon(Icons.person, size: 50)
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/whatsapp.png',
                              width: 30,
                            ),
                            title: const Text('Whatsapp'),
                            subtitle: Text(
                              _userDetails['phone'] ?? 'Not Available',
                            ),
                            onTap: () {
                              final phoneNumber = _userDetails['phone'];
                              if (phoneNumber != null) {
                                final whatsappUrl =
                                    'https://wa.me/$phoneNumber';
                                _launchUrl(whatsappUrl);
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/instagram.png',
                              width: 30,
                            ),
                            title: const Text('Instagram'),
                            subtitle: Text(
                              _userDetails['instagram'] ?? 'Not Available',
                            ),
                            onTap: () {
                              final instagramUsername =
                                  _userDetails['instagram'];
                              if (instagramUsername != null) {
                                final instagramUrl =
                                    'https://www.instagram.com/$instagramUsername';
                                _launchUrl(instagramUrl);
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/linkedin.png',
                              width: 30,
                            ),
                            title: const Text('Linkedin'),
                            subtitle: Text(
                              _userDetails['linkedin'] ?? 'Not Available',
                            ),
                            onTap: () {
                              final linkedinUsername =
                                  _userDetails['linkedin'];
                              if (linkedinUsername != null) {
                                final linkedinUrl =
                                    'https://www.linkedin.com/in/$linkedinUsername';
                                _launchUrl(linkedinUrl);
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: Image.asset(
                              'assets/images/github.png',
                              width: 30,
                            ),
                            title: const Text('Github'),
                            subtitle: Text(
                              _userDetails['github'] ?? 'Not Available',
                            ),
                            onTap: () {
                              final githubUsername = _userDetails['github'];
                              if (githubUsername != null) {
                                final githubUrl =
                                    'https://github.com/$githubUsername';
                                _launchUrl(githubUrl);
                              }
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
                          Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _userDetails['photourl'] != null
                                  ? CachedNetworkImageProvider(
                                      _userDetails['photourl']!,
                                    )
                                  : null,
                              child: _userDetails['photourl'] == null
                                  ? const Icon(Icons.person, size: 50)
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text('Logout'),
                            onTap: _logout,
                          ),
                          const SizedBox(height: 16),
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
