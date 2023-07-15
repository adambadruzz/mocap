import 'package:flutter/material.dart';
import 'package:mocap/view/pengurus_view.dart';

import '../viewmodel/navbar_viewmodel.dart';
import '../viewmodel/pengurusmenu_viewmodel.dart';
import 'navbar_view.dart';

class PengurusMenuView extends StatelessWidget {
  final PengurusMenuViewModel viewModel = PengurusMenuViewModel();

  PengurusMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> tahunKepengurusan = viewModel.generateTahunKepengurusan();
    final NavigationBarViewModel navBarViewModel = NavigationBarViewModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengurus Komunitas'),
      ),
      body: ListView.builder(
        itemCount: tahunKepengurusan.length,
        itemBuilder: (context, index) {
          final tahun = tahunKepengurusan[index];
          return ListTile(
            title: Text(tahun),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PengurusView(tahunSelesai: viewModel.getTahunSelesai(tahun)),
                ),
              );
            },
          );
        },
      ),
      
    );
  }
}