import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mocap/viewmodel/drawer_viewmodel.dart';

class DrawerView extends StatelessWidget {
  final DrawerViewModel viewModel;

  DrawerView({required this.viewModel});

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
                SizedBox(height: 10),
                Column(
                  children: [
                   Text(
                    '${FirebaseAuth.instance.currentUser!.email}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${FirebaseAuth.instance.currentUser!.email}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  ],
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
              viewModel.navigateToHomes();
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
              viewModel.navigateToProfile();
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
              viewModel.navigateToMembers();
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
              viewModel.navigateToCourses();
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
              viewModel.navigateToSettings();
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.update),
                SizedBox(width: 10),
                Text('Update'),
              ],
            ),
            onTap: () {
              viewModel.navigateToUpdates();
            },
          ),
          SizedBox(height: 10,),
          Divider(thickness: 2,),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 10),
                Text('Logout'),
              ],
            ),

            onTap: () {
              viewModel.logout();
            },
          ),
        ],      
      ),
    );
  }
}
