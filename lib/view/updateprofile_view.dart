import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mocap/constants.dart';
import 'package:mocap/global_widgets/textfield_dec.dart';
import 'package:mocap/view/profile_view.dart';

import '../viewmodel/updateprofile_viewmodel.dart';

class UpdateProfileView extends StatefulWidget {
  final UpdateProfileViewModel viewModel;

  const UpdateProfileView({Key? key, required this.viewModel})
      : super(key: key);

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  late Timestamp? _selectedDate;
  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    setState(() {
      _isLoading = true;
    });
    final userDetails = await widget.viewModel.getCurrentUser();
    setState(() {
      _isLoading = false;
      _nameController.text = userDetails['name'] ?? '';
      _emailController.text = userDetails['email'] ?? '';
      _phoneController.text = userDetails['phone'] ?? '';
      _instagramController.text = userDetails['instagram'] ?? '';
      _githubController.text = userDetails['github'] ?? '';
      _linkedinController.text = userDetails['linkedin'] ?? '';
      _selectedDate = userDetails['dob'] as Timestamp?;
    });
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    final updatedUserDetails = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'instagram': _instagramController.text,
      'whatsapp': _phoneController.text,
      'github': _githubController.text,
      'linkedin': _linkedinController.text,
      'dob': _selectedDate,
    };

    if (_selectedImage != null) {
      // Hapus foto lama dari Firebase Storage
      final String? oldPhotoUrl = await widget.viewModel.getProfilePhotoUrl();
      if (oldPhotoUrl != null) {
        await FirebaseStorage.instance.refFromURL(oldPhotoUrl).delete();
      }

      // Unggah foto terbaru ke Firebase Storage
      final photoUrl =
          await widget.viewModel.uploadProfilePhoto(_selectedImage!);
      updatedUserDetails['photourl'] = photoUrl;
    }

    await widget.viewModel.updateProfile(updatedUserDetails);

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileView()),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate?.toDate() ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate?.toDate()) {
      setState(() {
        _selectedDate = Timestamp.fromDate(pickedDate);
      });
    }
  }

  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Update Profile',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(paddingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: paddingM),
                  Center(
                    child: GestureDetector(
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
                  ),
                  const SizedBox(height: paddingM),
                  TextFormField(
                      controller: _nameController,
                      decoration: customTextFieldDecoration(
                        'Name',
                      )),
                  const SizedBox(height: paddingM),
                  TextFormField(
                      controller: _emailController,
                      decoration: customTextFieldDecoration(
                        'Email',
                      )),
                  const SizedBox(height: paddingM),
                  TextFormField(
                      controller: _phoneController,
                      decoration: customTextFieldDecoration(
                        'Phone',
                      )),
                  const SizedBox(height: paddingM),
                  const Text(
                    'Khusus untuk social media cukup masukkan username saja, tanpa link. Contoh: @username',
                    maxLines: 3,
                  ),
                  const SizedBox(height: paddingM),
                  TextFormField(
                      controller: _instagramController,
                      decoration: customTextFieldDecoration(
                        'Instagram',
                      )),
                  const SizedBox(height: paddingM),
                  TextFormField(
                      controller: _githubController,
                      decoration: customTextFieldDecoration(
                        'Github',
                      )),
                  const SizedBox(height: paddingM),
                  TextFormField(
                      controller: _linkedinController,
                      decoration: customTextFieldDecoration(
                        'Linkedin',
                      )),
                  const SizedBox(height: paddingM),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: InputDecorator(
                      decoration: customTextFieldDecoration(
                        'Date of Birth',
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd MMM yyyy').format(
                                _selectedDate?.toDate() ?? DateTime.now()),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            color: blueFigma,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: paddingM),
                  GestureDetector(
                    onTap: () {
                      _updateProfile();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(paddingM),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF406EA5),
                      ),
                      child: const Center(
                        child: Text('Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
