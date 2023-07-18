import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../viewmodel/createpost_viewmodel.dart';


class CreatePostView extends StatelessWidget {
  final CreatePostViewModel viewModel = Get.put(CreatePostViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CreatePostForm(),
        ),
      ),
    );
  }
}

class CreatePostForm extends StatefulWidget {
  @override
  _CreatePostFormState createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> {
  final ImagePicker _imagePicker = ImagePicker();

  late String _posttitleText;
  late String _postText;
  final List<File> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    final CreatePostViewModel viewModel = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: 'Enter your title',
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onChanged: (value) {
            setState(() {
              _posttitleText = value;
            });
          },
          maxLines: null,
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Enter your post',
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onChanged: (value) {
            setState(() {
              _postText = value;
            });
          },
          maxLines: null,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _selectImage(ImageSource.camera);
              },
              child: const Text('Take Photo'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                _selectImage(ImageSource.gallery);
              },
              child: const Text('Choose from Gallery'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _selectedImages.map((image) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedImages.remove(image);
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            viewModel.createPost(
              _posttitleText,
              _postText,
              _selectedImages,
            );
          },
          child: const Text('Create Post'),
        ),
      ],
    );
  }

  Future<void> _selectImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }
}
