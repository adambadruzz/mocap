import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../viewmodel/registergoogle_viewmodel.dart';


class RegisterGoogleView extends StatelessWidget {
  final RegisterGoogleViewModel _viewModel = Get.find();

  final TextEditingController _asalController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  late DateTime _selectedDate;
  File? _selectedImage;

  Future<void> _selectImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectedImage = File(image.path);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      _selectedDate = pickedDate;
    }
  }

  bool _validateInputs() {
    if (_selectedImage == null) {
      _viewModel.showErrorMessage('Please select an image');
      return false;
    }

    if (_asalController.text.isEmpty) {
      _viewModel.showErrorMessage('Please enter your origin');
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register with Google'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _selectImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: _selectedImage != null
                      ? DecorationImage(
                          image: FileImage(_selectedImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _selectedImage == null
                    ? const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(10),
              child: DropdownButtonFormField<String>(
                value: _viewModel.selectedYear,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Angkatan',
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _viewModel.setSelectedYear(newValue);
                  }
                },
                items: _viewModel.yearList
                    .map(
                      (year) => DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _asalController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Asal',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Birthdate',
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd MMM yyyy').format(_selectedDate),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_validateInputs()) {
                  _viewModel.signInWithGoogle(
                     
                    angkatan: _viewModel.selectedYear,
                    asal: _asalController.text,
                    selectedDate: _selectedDate,
                    profileImage: _selectedImage,
                    instagram: _instagramController.text.isEmpty ? 'Not Available' : _instagramController.text,
                    github: _githubController.text.isEmpty ? 'Not Available' : _githubController.text,
                    linkedin: _linkedinController.text.isEmpty ? 'Not Available' : _linkedinController.text,
                  );
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
