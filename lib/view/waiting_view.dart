import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../viewmodel/waiting_viewmodel.dart';

class WaitingView extends StatelessWidget {
  final WaitingViewModel viewModel = Get.put(WaitingViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waiting View"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => viewModel.logout(context),
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
              onPressed: () => viewModel.openWhatsAppChat(),
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
