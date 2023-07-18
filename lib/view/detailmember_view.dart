import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/member_model.dart';
import '../viewmodel/detailmember_viewmodel.dart';

class DetailMemberView extends StatelessWidget {
  final MemberModel member;

  DetailMemberView({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailMemberViewModel>(
      init: DetailMemberViewModel(member: member),
      builder: (viewModel) {
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
                    labelColor: Colors.black,
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
                                  subtitle: Text(viewModel.formatDateOfBirth(member.dob) ?? 'N/A'),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: const Text('Phone'),
                                  subtitle: Text(member.phone),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: const Text('Role'),
                                  subtitle: Text(member.role),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: const Text('Asal'),
                                  subtitle: Text(
                                    member.asal,
                                  ),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: const Text('Angkatan'),
                                  subtitle: Text(
                                    member.angkatan,
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
                                  member.phone,
                                ),
                                onTap: () {
                                  final phoneNumber = member.phone;
                                  final whatsappUrl = 'https://wa.me/$phoneNumber';
                                  viewModel.launchUrl(whatsappUrl);
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
                                  member.instagram,
                                ),
                                onTap: () {
                                  final instagramUsername = member.instagram;
                                  final instagramUrl = 'https://www.instagram.com/$instagramUsername';
                                  viewModel.launchUrl(instagramUrl);
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
                                  member.linkedin,
                                ),
                                onTap: () {
                                  final linkedinUsername = member.linkedin;
                                  final linkedinUrl = 'https://www.linkedin.com/in/$linkedinUsername';
                                  viewModel.launchUrl(linkedinUrl);
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
                                  member.github,
                                ),
                                onTap: () {
                                  final githubUsername = member.github;
                                  final githubUrl = 'https://github.com/$githubUsername';
                                  viewModel.launchUrl(githubUrl);
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
        );
      },
    );
  }
}
