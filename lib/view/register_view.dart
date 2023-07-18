import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mocap/viewmodel/register_viewmodel.dart';

class RegisterView extends StatelessWidget {
  final RegisterViewModel _viewModel = Get.find();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _angkatanController = TextEditingController();
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

    if (_emailController.text.isEmpty) {
      _viewModel.showErrorMessage('Please enter an email');
      return false;
    }

    if (_passwordController.text.isEmpty) {
      _viewModel.showErrorMessage('Please enter a password');
      return false;
    }

    if (_confirmPasswordController.text.isEmpty) {
      _viewModel.showErrorMessage('Please enter a confirm password');
      return false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _viewModel.showErrorMessage('Password and Confirm Password must be the same');
      return false;
    }

    if (_nameController.text.isEmpty) {
      _viewModel.showErrorMessage('Please enter your full name');
      return false;
    }

    if (_phoneController.text.isEmpty) {
      _viewModel.showErrorMessage('Please enter a phone number');
      return false;
    }

    if (!_phoneController.text.startsWith('62')) {
      _viewModel.showErrorMessage('Phone number must start with 62');
      return false;
    }

    if (_angkatanController.text.isEmpty) {
      _viewModel.showErrorMessage('Please enter the year of entry');
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
        title: const Text('Register'),
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
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _angkatanController,
              decoration: const InputDecoration(
                labelText: 'Year of Entry',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _asalController,
              decoration: const InputDecoration(
                labelText: 'Origin',
              ),
            ),
            const SizedBox(height: 8.0),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Birthdate',
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(_selectedDate),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _instagramController,
              decoration: const InputDecoration(
                labelText: 'Instagram',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _githubController,
              decoration: const InputDecoration(
                labelText: 'GitHub',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _linkedinController,
              decoration: const InputDecoration(
                labelText: 'LinkedIn',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_validateInputs()) {
                  _viewModel.signUp(
                    email: _emailController.text,
                    password: _passwordController.text,
                    confirmpassword: _confirmPasswordController.text,
                    name: _nameController.text,
                    phone: _phoneController.text,
                    angkatan: _angkatanController.text,
                    asal: _asalController.text,
                    instagram: _instagramController.text,
                    github: _githubController.text,
                    linkedin: _linkedinController.text,
                    selectedDate: _selectedDate,
                    profileImage: _selectedImage,
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

