import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';
import 'package:mocap/global_widgets/button.dart';
import 'package:mocap/view/pengurus_view.dart';

import '../viewmodel/pengurusmenu_viewmodel.dart';

class PengurusMenuView extends StatelessWidget {
  final PengurusMenuViewModel viewModel = PengurusMenuViewModel();

  PengurusMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> tahunKepengurusan =
        viewModel.generateTahunKepengurusan();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Pengurus Komunitas", style: headline2),
        centerTitle: true,
        iconTheme: const IconThemeData(color: black),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: tahunKepengurusan.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final tahun = tahunKepengurusan[index];
          return button(Icons.group, tahun, false, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PengurusView(
                    tahunSelesai: viewModel.getTahunSelesai(tahun)),
              ),
            );
          });
          // return ListTile(
          //   title: Text(tahun),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => PengurusView(tahunSelesai: viewModel.getTahunSelesai(tahun)),
          //       ),
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
