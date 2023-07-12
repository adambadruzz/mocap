import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../viewmodel/home_viemodel.dart';
import '../viewmodel/navbar_viewmodel.dart';
import 'navbar_view.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel viewModel;
  final NavigationBarViewModel _navBarViewModel = NavigationBarViewModel();

  HomeView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: null, // Hapus ikon AppBar
        actions: null
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.navigateToEvent();
                      },
                      child: Icon(
                        Icons.event,
                        size: 50,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Event',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.navigateToMembers();
                      },
                      child: Icon(
                        Icons.people,
                        size: 50,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Members',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.navigateToCourses();
                      },
                      child: Icon(
                        Icons.book,
                        size: 50,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Courses',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.navigateToStructure();
                      },
                      child: Icon(
                        Icons.group,
                        size: 50,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Structure',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: NavBarView(
        viewModel: _navBarViewModel,
      ),
    );
  }
}

