import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mocap/view/navbar_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../viewmodel/navbar_viewmodel.dart';
import '../viewmodel/profile_viewmodel.dart';
import '../viewmodel/updateprofile_viewmodel.dart';
import 'updateprofile_view.dart';

class ProfileView extends GetView<ProfileViewModel> {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: DefaultTabController(
        length: 3,
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
                  Tab(text: 'Settings'),
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
                              backgroundImage: controller.userDetails.value['photourl'] != null
                                  ? CachedNetworkImageProvider(controller.userDetails.value['photourl']!)
                                  : null,
                              child: controller.userDetails.value['photourl'] == null
                                  ? const Icon(Icons.person, size: 50)
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            child: ListTile(
                              title: const Text('Name'),
                              subtitle: Text(controller.userDetails.value['name'] ?? 'Loading...'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Email'),
                              subtitle: Text(controller.userDetails.value['email'] ?? 'Loading...'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Date of Birth'),
                              subtitle: Text(
                                _formatDateOfBirth(controller.userDetails.value['dob']) ?? 'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Phone'),
                              subtitle: Text(controller.userDetails.value['phone'] ?? 'Loading...'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Role'),
                              subtitle: Text(controller.userDetails.value['role'] ?? 'Loading...'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Asal'),
                              subtitle: Text(controller.userDetails.value['asal'] ?? 'Loading...'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Angkatan'),
                              subtitle: Text(controller.userDetails.value['angkatan'] ?? 'Loading...'),
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
                              backgroundImage: controller.userDetails.value['photourl'] != null
                                  ? CachedNetworkImageProvider(controller.userDetails.value['photourl']!)
                                  : null,
                              child: controller.userDetails.value['photourl'] == null
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
                            subtitle: Text(controller.userDetails.value['phone'] ?? 'Not Available'),
                            onTap: () {
                              final phoneNumber = controller.userDetails.value['phone'];
                              if (phoneNumber != null) {
                                final whatsappUrl = 'https://wa.me/$phoneNumber';
                                launch(whatsappUrl);
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
                            subtitle: Text(controller.userDetails.value['instagram'] ?? 'Not Available'),
                            onTap: () {
                              final instagramUsername = controller.userDetails.value['instagram'];
                              if (instagramUsername != null) {
                                final instagramUrl = 'https://www.instagram.com/$instagramUsername';
                                launch(instagramUrl);
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
                            subtitle: Text(controller.userDetails.value['linkedin'] ?? 'Not Available'),
                            onTap: () {
                              final linkedinUsername = controller.userDetails.value['linkedin'];
                              if (linkedinUsername != null) {
                                final linkedinUrl = 'https://www.linkedin.com/in/$linkedinUsername';
                                launch(linkedinUrl);
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
                            subtitle: Text(controller.userDetails.value['github'] ?? 'Not Available'),
                            onTap: () {
                              final githubUsername = controller.userDetails.value['github'];
                              if (githubUsername != null) {
                                final githubUrl = 'https://github.com/$githubUsername';
                                launch(githubUrl);
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
                              backgroundImage: controller.userDetails.value['photourl'] != null
                                  ? CachedNetworkImageProvider(controller.userDetails.value['photourl']!)
                                  : null,
                              child: controller.userDetails.value['photourl'] == null
                                  ? const Icon(Icons.person, size: 50)
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text('Update Profile'),
                            onTap: () {
                              Get.to(() => UpdateProfileView);
                            },
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Delete Account'),
                            onTap: controller.deleteAccount,
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text('Logout'),
                            onTap: controller.logout,
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
