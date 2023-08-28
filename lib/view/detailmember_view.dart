import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:mocap/constants.dart';
import 'package:mocap/global_widgets/app_bar.dart';
import 'package:mocap/global_widgets/icon_button.dart';
import '../models/member_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMemberView extends StatelessWidget {
  final MemberModel member;

  DetailMemberView({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Detail Member"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: member.photourl.isNotEmpty
                          ? CachedNetworkImageProvider(member.photourl)
                              as ImageProvider<Object>?
                          : null,
                      child: member.photourl.isEmpty
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DottedBorder(
                    color: blueFigma,
                    strokeWidth: 1,
                    strokeCap: StrokeCap.round,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    dashPattern: const [12, 8],
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(paddingL),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            customIconButton("assets/images/instagram.png", () {
                              final instagramUsername = member.instagram;
                              final instagramUrl =
                                  'https://www.instagram.com/$instagramUsername';
                              _launchUrl(instagramUrl);
                            }),
                            customIconButton("assets/images/github.png", () {
                              final githubUsername = member.github;
                              final githubUrl =
                                  'https://github.com/$githubUsername';
                              _launchUrl(githubUrl);
                            }),
                            customIconButton("assets/images/whatsapp.png", () {
                              final phoneNumber = member.phone;
                              final whatsappUrl = 'https://wa.me/$phoneNumber';
                              _launchUrl(whatsappUrl);
                            }),
                            customIconButton("assets/images/linkedin.png", () {
                              final linkedinUsername = member.linkedin;
                              final linkedinUrl =
                                  'https://www.linkedin.com/in/$linkedinUsername';
                              _launchUrl(linkedinUrl);
                            })
                          ],
                        )),
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
          ],
        ),
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

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
