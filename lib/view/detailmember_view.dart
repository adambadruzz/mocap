import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../models/member_model.dart';
import '../viewmodel/navbar_viewmodel.dart';
import 'navbar_view.dart';

class DetailMemberView extends StatelessWidget {
  final MemberModel member;
  final NavigationBarViewModel _navBarViewModel = NavigationBarViewModel();

  DetailMemberView({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Detail'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: TabBar(
                labelColor: Colors.black, // Mengubah warna teks menjadi hitam
                indicatorColor: Colors.green.shade700,
                tabs: const [
                  Tab(text: 'Information'),
                  Tab(text: 'Social Media'),
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
                              backgroundImage: member.photourl.isNotEmpty
                                  ? CachedNetworkImageProvider(member.photourl) as ImageProvider<Object>?
                                  : null,
                              child: member.photourl.isEmpty
                                  ? const Icon(Icons.person, size: 50)
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            child: ListTile(
                              title: const Text('Name'),
                              subtitle: Text(member.name),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Email'),
                              subtitle: Text(member.email),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Date of Birth'),
                              subtitle: Text(_formatDateOfBirth(member.dob) ?? 'N/A'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Phone'),
                              subtitle: Text(member.phone ?? 'N/A'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Role'),
                              subtitle: Text(member.role ?? 'N/A'),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Asal'),
                              subtitle: Text(
                                member.asal ?? 'Loading...',
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Angkatan'),
                              subtitle: Text(
                                member.angkatan ?? 'Loading...',
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
                              backgroundImage: member.photourl.isNotEmpty
                                  ? CachedNetworkImageProvider(member.photourl) as ImageProvider<Object>?
                                  : null,
                              child: member.photourl.isEmpty
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
                              member.phone ?? 'Not Available',
                            ),
                            onTap: () {
                              // Add your logic here to open Whatsapp profile
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
                              member.instagram ?? 'Not Available',
                            ),
                            onTap: () {
                              // Add your logic here to open Instagram profile
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
                              member.linkedin ?? 'Not Available',
                            ),
                            onTap: () {
                              // Add your logic here to open Linkedin profile
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
                              member.github ?? 'Not Available',
                            ),
                            onTap: () {
                              // Add your logic here to open Github profile
                            },
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

  String? _formatDateOfBirth(DateTime? dateTime) {
    if (dateTime != null) {
      final formatter = DateFormat('dd MMM yyyy');
      return formatter.format(dateTime);
    }
    return null;
  }
}


