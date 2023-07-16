import 'package:flutter/material.dart';
import '../viewmodel/coursemenu_viewmodel.dart';

class CourseMenuView extends StatelessWidget {
  final CourseMenuViewModel viewModel;

  CourseMenuView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Menu'),
        leading: null,
        actions: [
          FutureBuilder<bool>(
            future: viewModel.isAdmin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(); // Tampilkan widget kosong saat menunggu hasil
              }
              if (snapshot.hasData && snapshot.data!) {
                // Tampilkan ikon tambah course hanya jika pengguna memiliki specialRole 'admin'
                return IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    viewModel.navigateToAddCourse(context);
                  },
                );
              }
              return Container(); // Tampilkan widget kosong jika pengguna tidak memiliki specialRole 'admin'
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.navigateToJava();
                      },
                      child: Image.asset(
                        'assets/images/java.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Java',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.navigateToKotlin();
                      },
                      child: Image.asset(
                        'assets/images/kotlin.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Kotlin',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.navigateToFlutter();
                      },
                      child: Image.asset(
                        'assets/images/flutter.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Flutter',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        viewModel.navigateToJS();
                      },
                      child: Image.asset(
                        'assets/images/js.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'JavaScript',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
