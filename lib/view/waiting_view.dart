import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WaitingView extends StatelessWidget {

  

final Uri _url = Uri.parse('https://flutter.dev');

  Future<void> _openWhatsAppChat() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Waiting View"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tunggu untuk mendapatkan akses aplikasi",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            IconButton(
              icon: Image.asset('assets/images/whatsapp.png'),
              onPressed: _openWhatsAppChat,
            ),
            SizedBox(height: 8),
            Text(
              "Konfirmasi ke nomor WhatsApp",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
