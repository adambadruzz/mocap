import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import '../viewmodel/home_viemodel.dart';
import 'home_view.dart';

class DetailEventView extends StatelessWidget {
  final PostModel post;

  DetailEventView({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
  FutureBuilder<bool>(
    future: post.hasSpecialRole(),
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
            _showConfirmationDialog(context); // Menampilkan dialog konfirmasi sebelum menghapus
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.images.isNotEmpty)
              SizedBox(
                height: 200,
                width: double.infinity,
                child: PageView.builder(
                  itemCount: post.images.length,
                  itemBuilder: (context, index) {
                    final imageUrl = post.images[index];
                    return Image.network(imageUrl);
                  },
                ),
              ),
              const SizedBox(height: 16),
            const Text(
              'Title:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(post.title),

            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(post.description),
          ],
        ),
      ),
      
    );
    
  }
  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Event'),
          content: const Text('Are you sure you want to delete this event?'),
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
                _deleteEvent(context); // Call method to delete the event
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteEvent(BuildContext context) async {
  try {
    // Hapus dokumen event dari Firestore
    await FirebaseFirestore.instance.collection('posts').doc(post.id).delete();

    // Hapus gambar-gambar terkait di Firebase Storage
    final List<String> imageUrls = post.images;
    for (final imageUrl in imageUrls) {
      // Mendapatkan nama file dari URL gambar
      final fileName = imageUrl.split('%2F').last.split('?').first;

      // Menghapus file dari Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child('post_images/$fileName');
      await storageRef.delete();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeView(viewModel: HomeViewModel(context: context))),
    );
  } catch (e) {
    // Handle the error accordingly
    print('Error deleting event: $e');
  }
}

}
