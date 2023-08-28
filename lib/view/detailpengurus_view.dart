import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:mocap/constants.dart';
import 'package:mocap/global_widgets/icon_button.dart';
import '../models/member_model.dart';
import '../viewmodel/home_viemodel.dart';
import 'home_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPengurusView extends StatelessWidget {
  final MemberModel member;

  DetailPengurusView({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengurus Detail'),
        actions: [
          FutureBuilder<bool>(
            future: member.hasSpecialRole(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Menampilkan loading spinner jika masih dalam proses pengambilan data
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Menampilkan pesan error jika terjadi kesalahan
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data == true) {
                // Menampilkan ikon delete jika user memiliki special role 'admin'
                return IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _showConfirmationDialog(
                        context); // Menampilkan dialog konfirmasi sebelum menghapus
                  },
                );
              } else {
                // Tidak menampilkan ikon delete jika user tidak memiliki special role 'admin'
                return const SizedBox();
              }
            },
          ),
        ],
      ),
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
                      subtitle: Text(member.roles),
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

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Pengurus'),
          content: const Text('Are you sure you want to delete this pengurus?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deletePengurus(context); // Call method to delete the pengurus
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deletePengurus(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.uid == member.id) {
      await user.delete();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final currentUser = FirebaseAuth.instance.currentUser;

      // Pastikan user sudah login menggunakan akun Google
      if (currentUser?.providerData
              .any((info) => info.providerId == 'google.com') ==
          true) {
        try {
          await googleSignIn.disconnect();
          // Setelah berhasil memutuskan hubungan, Anda dapat menghapus akun Firebase Auth jika diperlukan
          await currentUser?.delete();
          print(
              'Akun Google berhasil diputuskan hubungannya dan akun Firebase Auth dihapus.');
        } catch (e) {
          print('Gagal memutuskan hubungan akun Google: $e');
        }
      } else {
        print('User tidak login dengan akun Google.');
      }
    }

    try {
      // Hapus file dari Firebase Storage (jika ada)
      if (member.photourl.isNotEmpty) {
        await FirebaseStorage.instance.refFromURL(member.photourl).delete();
      }

      // Hapus dokumen pengurus dari Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(member
              .id) // Ubah ini sesuai dengan ID dokumen pengurus yang akan dihapus
          .delete();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HomeView(viewModel: HomeViewModel(context: context))),
      );
    } catch (e) {
      // Handle the error accordingly
      print('Error deleting pengurus: $e');
    }
  }
}
