import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class WaitingView extends StatelessWidget {

final Uri _url = Uri.parse('http://wa.me/6287884273699?text=HaloKak');

   WaitingView({Key? key}) : super(key: key);

  Future<void> _openWhatsAppChat() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
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
            onPressed: () {
                  Navigator.pop(context);
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
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
