import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/member_model.dart';
import '../view/home_view.dart';
import 'home_viemodel.dart';

class DetailPengurusViewModel extends GetxController {
  final MemberModel member;

  DetailPengurusViewModel({required this.member});

  String? formatDateOfBirth(DateTime? dateTime) {
    if (dateTime != null) {
      final formatter = DateFormat('dd MMM yyyy');
      return formatter.format(dateTime);
    }
    return null;
  }

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
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
                deletePengurus(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deletePengurus(BuildContext context) async {
    // Hapus pengurus dari Firestore
    await FirebaseFirestore.instance.collection('users').doc(member.id).delete();

    // Hapus file dari Firebase Storage jika ada
    if (member.photourl.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(member.photourl).delete();
    }

    // Navigasi kembali ke halaman HomeView setelah menghapus pengurus
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeView()),
    );
  }
}
