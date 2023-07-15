import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class WaitingView extends StatelessWidget {
  WaitingView({Key? key}) : super(key: key);

  Future<void> _openWhatsAppChat() async {
    final phoneNumber = '6287884273699';

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userData =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userData.exists) {
        final name = userData['name'];
        final email = userData['email'];
        final angkatan = userData['angkatan'];
        final asal = userData['asal'];

        final message =
            'Halo kak! aku udah daftar buat jadi member mocap, ini identitasnya:\n\n'
            'Nama: $name\n'
            'Email: $email\n'
            'Angkatan: $angkatan\n'
            'Asal: $asal\n\n'
            'Ditunggu ya kak aksesnya, makasih kak';

        final url =
            'https://wa.me/$phoneNumber/?text=${Uri.encodeComponent(message)}';

        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw Exception('Could not launch $url');
        }
      } else {
        throw Exception('User data not found');
      }
    } else {
      throw Exception('User not logged in');
    }
  }

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waiting View"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Tunggu untuk mendapatkan akses aplikasi",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            IconButton(
              icon: Image.asset('assets/images/whatsapp.png'),
              onPressed: _openWhatsAppChat,
            ),
            const SizedBox(height: 8),
            const Text(
              "Konfirmasi ke nomor WhatsApp",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
