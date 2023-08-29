import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';
import 'package:mocap/global_widgets/textfield_dec.dart';
import 'package:mocap/viewmodel/register_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  final RegisterViewModel viewModel;

  const RegisterView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final asalController = TextEditingController();
  final instagramController = TextEditingController();
  final whatsappController = TextEditingController();
  final githubController = TextEditingController();
  final linkedinController = TextEditingController();
  late DateTime selectedDate;
  late String selectedYear;
  File? _selectedImage;

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<String> _uploadImageToFirebase() async {
    if (_selectedImage == null) {
      return '';
    }

    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final UploadTask uploadTask = storageRef.putFile(_selectedImage!);
    final TaskSnapshot storageSnapshot = await uploadTask;
    final String downloadUrl = await storageSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedYear = DateTime.now().year.toString();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  bool validateInputs() {
    if (_selectedImage == null) {
      widget.viewModel.showErrorMessage(context, 'Please select an image');
      return false;
    }

    if (emailController.text.isEmpty) {
      widget.viewModel.showErrorMessage(context, 'Please enter an email');
      return false;
    }

    if (passwordController.text.isEmpty) {
      widget.viewModel.showErrorMessage(context, 'Please enter a password');
      return false;
    }

    if (confirmpasswordController.text.isEmpty) {
      widget.viewModel
          .showErrorMessage(context, 'Please enter a confirm password');
      return false;
    }

    if (passwordController.text != confirmpasswordController.text) {
      widget.viewModel.showErrorMessage(
          context, 'Password and Confirm Password must be the same');
      return false;
    }

    if (nameController.text.isEmpty) {
      widget.viewModel.showErrorMessage(context, 'Please enter your fullname');
      return false;
    }

    if (phoneController.text.isEmpty) {
      widget.viewModel.showErrorMessage(context, 'Please enter a phone number');
      return false;
    }

    if (!phoneController.text.startsWith('62')) {
      widget.viewModel
          .showErrorMessage(context, 'Phone number must start with 62');
      return false;
    }

    if (selectedYear.isEmpty) {
      widget.viewModel
          .showErrorMessage(context, 'Please select the year of entry');
      return false;
    }

    if (asalController.text.isEmpty) {
      widget.viewModel.showErrorMessage(context, 'Please enter your origin');
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(paddingL),
          child: Column(children: [
            const Text('Lets Create Your Account!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: paddingM),
            GestureDetector(
              onTap: () {
                _selectImage();
              },
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
            const SizedBox(height: paddingM),
            TextField(
                controller: emailController,
                decoration: customTextFieldDecoration('Email')),
            const SizedBox(height: paddingM),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: customTextFieldDecoration('Password'),
            ),
            const SizedBox(height: paddingM),
            TextField(
              controller: confirmpasswordController,
              obscureText: true,
              decoration: customTextFieldDecoration('Confirm Password'),
            ),
            const SizedBox(height: paddingM),
            TextField(
              controller: nameController,
              decoration: customTextFieldDecoration('Fullname'),
            ),
            const SizedBox(height: paddingM),
            TextField(
              controller: phoneController,
              decoration: customTextFieldDecoration('Phone Number (62)'),
            ),
            const SizedBox(height: paddingM),
            DropdownButtonFormField<String>(
              value: selectedYear,
              decoration: customTextFieldDecoration('Year of Entry'),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedYear = newValue;
                  });
                }
              },
              items: List<DropdownMenuItem<String>>.generate(
                10, // Jumlah tahun yang ingin ditampilkan
                (int index) {
                  final year = DateTime.now().year - index;
                  return DropdownMenuItem<String>(
                    value: year.toString(),
                    child: Text(year.toString()),
                  );
                },
              ),
            ),
            const SizedBox(height: paddingM),
            TextField(
              controller: asalController,
              decoration: customTextFieldDecoration('Address'),
            ),
            const SizedBox(height: paddingM),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: InputDecorator(
                decoration: customTextFieldDecoration('Date of Birth'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(selectedDate),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: paddingM),
            GestureDetector(
              onTap: () {
                if (validateInputs()) {
                  widget.viewModel.signUp(
                    email: emailController.text,
                    password: passwordController.text,
                    confirmpassword: confirmpasswordController.text,
                    nameController: nameController.text,
                    phoneController: phoneController.text,
                    angkatan: selectedYear,
                    asal: asalController.text,
                    instagram: instagramController.text.isEmpty
                        ? 'Not Available'
                        : instagramController.text,
                    github: githubController.text.isEmpty
                        ? 'Not Available'
                        : githubController.text,
                    linkedin: linkedinController.text.isEmpty
                        ? 'Not Available'
                        : linkedinController.text,
                    selectedDate: selectedDate,
                    profileImage: _selectedImage,
                    context: context,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(paddingM),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF406EA5),
                ),
                child: const Center(
                  child: Text('Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?',
                    style: customTextStyle(14.0, FontWeight.w500, black)),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Login',
                    style: customTextStyle(14.0, FontWeight.w500, blueFigma),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
