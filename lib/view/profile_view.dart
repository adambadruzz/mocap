import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';
import '../viewmodel/drawer_viewmodel.dart';
import '../viewmodel/profile_viewmodel.dart';
import 'drawer_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';


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
            Center(
        child: CircleAvatar(
          radius: 50,
          backgroundImage: _userDetails['photourl'] != null
              ? CachedNetworkImageProvider(_userDetails['photourl']!)
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
                subtitle: Text(_userDetails['name'] ?? 'Loading...'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Email'),
                subtitle: Text(_userDetails['email'] ?? 'Loading...'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Date of Birth'),
                subtitle: Text(_formatDateOfBirth(_userDetails['dob']) ?? 'Loading...'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Phone'),
                subtitle: Text(_userDetails['phone'] ?? 'Loading...'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Role'),
                subtitle: Text(_userDetails['role'] ?? 'Loading...'),
              ),
            ),
          ],
        ),
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
