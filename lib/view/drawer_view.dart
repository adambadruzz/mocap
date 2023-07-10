import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mocap/viewmodel/drawer_viewmodel.dart';

class DrawerView extends StatefulWidget {
  final DrawerViewModel viewModel;

  DrawerView({required this.viewModel});

  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  String _namaPanjang = '';

  @override
  void initState() {
    super.initState();
    _fetchNamaPanjang();
  }

  Future<void> _fetchNamaPanjang() async {
    final user = FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .get();
    final data = snapshot.data() as Map<String, dynamic>;
    setState(() {
      _namaPanjang = data['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/google.png'),
                ),
                SizedBox(height: 25),
                Text(
                      _namaPanjang,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.home),
                SizedBox(width: 10),
                Text('Home'),
              ],
            ),
            onTap: () {
              widget.viewModel.navigateToHomes();
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 10),
                Text('Profile'),
              ],
            ),
            onTap: () {
              widget.viewModel.navigateToProfile();
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.event),
                SizedBox(width: 10),
                Text('Event'),
              ],
            ),
            onTap: () {
              widget.viewModel.navigateToEvent();
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.people),
                SizedBox(width: 10),
                Text('Member'),
              ],
            ),
            onTap: () {
              widget.viewModel.navigateToMembers();
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.book),
                SizedBox(width: 10),
                Text('Courses'),
              ],
            ),
            onTap: () {
              widget.viewModel.navigateToCourses();
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.settings),
                SizedBox(width: 10),
                Text('Settings'),
              ],
            ),
            onTap: () {
              widget.viewModel.navigateToSettings();
            },
          ),
          SizedBox(height: 10,),
          Divider(thickness: 2,),
          
          ListTile(
            title: Row(
              children: [
                Icon(Icons.update),
                SizedBox(width: 10),
                Text('Update'),
              ],
            ),
            onTap: () {
              widget.viewModel.navigateToUpdates();
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 10),
                Text('Logout'),
              ],
            ),

            onTap: () {
              widget.viewModel.logout();
            },
          ),
        ],
      ),
    );
  }
}
