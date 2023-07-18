import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WaitingViewModel extends GetxController {
  Future<void> openWhatsAppChat() async {
    const phoneNumber = '6287884273699';

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

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Get.back();
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
