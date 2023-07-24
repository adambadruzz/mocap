import 'package:flutter/material.dart';
import 'package:mocap/viewmodel/profile_viewmodel.dart';

import '../constants.dart';
import '../viewmodel/home_viemodel.dart';
import '../viewmodel/navbar_viewmodel.dart';
import 'navbar_view.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  HomeView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final NavigationBarViewModel _navBarViewModel = NavigationBarViewModel();

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
    return FutureBuilder<bool>(
      future: widget.viewModel.shouldShowCoursesMenu(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final shouldShowCoursesMenu = snapshot.data ?? false;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text('Home',
                  style: TextStyle(
                    color: black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  )),
              leading: null,
              actions: null,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Hi, ${_userDetails['name']}!',
                        style: const TextStyle(
                          color: black,
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                    const Row(
                    children: [
                      Text(
                        'Welcome to the team!',
                        style: TextStyle(
                          color: lightBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.viewModel.navigateToEvent();
                              },
                              child: const Icon(
                                Icons.event,
                                size: 50,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Event',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.viewModel.navigateToMembers();
                              },
                              child: const Icon(
                                Icons.people,
                                size: 50,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (shouldShowCoursesMenu) ...[
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            widget.viewModel.navigateToCourses();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.book,
                                  size: 50,
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
                        ),
                      ],
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.viewModel.navigateToStructure();
                              },
                              child: const Icon(
                                Icons.group,
                                size: 50,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
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
                  FutureBuilder<bool>(
                    future: widget.viewModel.isUserAdmin(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final bool isAdmin = snapshot.data ?? false;
            
                        return GestureDetector(
                          onTap: () {
                            widget.viewModel.navigateToAccess();
                          },
                          child: Visibility(
                            visible: isAdmin,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    size: 50,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Access',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: NavBarView(
              viewModel: _navBarViewModel,
            ),
          );
        }
      },
    );
  }
}
