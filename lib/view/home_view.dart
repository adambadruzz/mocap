import 'package:flutter/material.dart';
import 'package:mocap/global_widgets/card_feature.dart';
import 'package:mocap/viewmodel/profile_viewmodel.dart';

import '../constants.dart';
import '../viewmodel/home_viemodel.dart';
import '../viewmodel/navbar_viewmodel.dart';
import 'navbar_view.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomeView({Key? key, required this.viewModel}) : super(key: key);

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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final shouldShowCoursesMenu = snapshot.data ?? false;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Home',
                style: headline2,
              ),
              leading: null,
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Icon(Icons.notifications_none_rounded, color: black),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hi, ${_userDetails['name']}!',
                          style: headline1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      children: [
                        Text('Welcome to the team!', style: headline2Light),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28.0, vertical: 40.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: white,
                          boxShadow: [cardShadow]),
                      child: Row(
                        children: [
                          const Flexible(
                              child: Text(
                                  "Introducing the Mobile Community application",
                                  style: paragraphRegular)),
                          Image.asset("assets/images/illus_mocap.png"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    const Text("Feature", style: headline2),
                    const SizedBox(height: 16.0),
                    GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 16,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        cardFeature("assets/icon/icon_organ.png",
                            "Organizational Structure", "Team Hierarchy", () {
                          widget.viewModel.navigateToStructure();
                        }),
                        cardFeature("assets/icon/icon_course.png", "Courses",
                            "Learning Path", () {}),
                        cardFeature("assets/icon/icon_post.png", "Post",
                            "For Updates", () {}),
                        cardFeature("assets/icon/icon_member.png", "Members",
                            "Community Network", () {
                          widget.viewModel.navigateToMembers();
                        }),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.all(15),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         color: Colors.white,
                    //       ),
                    //       child: Column(
                    //         children: [
                    //           GestureDetector(
                    //             onTap: () {
                    //               widget.viewModel.navigateToEvent();
                    //             },
                    //             child: const Icon(
                    //               Icons.event,
                    //               size: 50,
                    //             ),
                    //           ),
                    //           const SizedBox(height: 8),
                    //           const Text(
                    //             'Event',
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     const SizedBox(width: 16),
                    //     Container(
                    //       padding: const EdgeInsets.all(15),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         color: Colors.white,
                    //       ),
                    //       child: Column(
                    //         children: [
                    //           GestureDetector(
                    //             onTap: () {
                    //               widget.viewModel.navigateToMembers();
                    //             },
                    //             child: const Icon(
                    //               Icons.people,
                    //               size: 50,
                    //             ),
                    //           ),
                    //           const SizedBox(height: 8),
                    //           const Text(
                    //             'Members',
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     if (shouldShowCoursesMenu) ...[
                    //       const SizedBox(height: 16),
                    //       GestureDetector(
                    //         onTap: () {
                    //           widget.viewModel.navigateToCourses();
                    //         },
                    //         child: Container(
                    //           padding: const EdgeInsets.all(15),
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(10),
                    //             color: Colors.white,
                    //           ),
                    //           child: const Column(
                    //             children: [
                    //               Icon(
                    //                 Icons.book,
                    //                 size: 50,
                    //               ),
                    //               SizedBox(height: 8),
                    //               Text(
                    //                 'Courses',
                    //                 style: TextStyle(
                    //                   fontSize: 16,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //     const SizedBox(width: 16),
                    //     Container(
                    //       padding: const EdgeInsets.all(15),
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         color: Colors.white,
                    //       ),
                    //       child: Column(
                    //         children: [
                    //           GestureDetector(
                    //             onTap: () {
                    //               widget.viewModel.navigateToStructure();
                    //             },
                    //             child: const Icon(
                    //               Icons.group,
                    //               size: 50,
                    //             ),
                    //           ),
                    //           const SizedBox(height: 8),
                    //           const Text(
                    //             'Structure',
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    FutureBuilder<bool>(
                      future: widget.viewModel.isUserAdmin(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
            ),
          );
        }
      },
    );
  }
}
