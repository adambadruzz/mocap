import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mocap/view/profile_view.dart';

import '../viewmodel/navbar_viewmodel.dart';
import '../viewmodel/profile_viewmodel.dart';
import '../viewmodel/updateprofile_viewmodel.dart';
import 'navbar_view.dart';

class UpdateProfileView extends StatefulWidget {
  final UpdateProfileViewModel viewModel;

  const UpdateProfileView({Key? key, required this.viewModel}) : super(key: key);

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
  late Timestamp? _selectedDate; // Update tipe data menjadi Timestamp?
  final NavigationBarViewModel _navBarViewModel = NavigationBarViewModel();

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
      _selectedDate = userDetails['dob'] as Timestamp?; // Menggunakan tipe Timestamp
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

    await widget.viewModel.updateProfile(updatedUserDetails);

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('Profile updated successfully')),
    );

    //write me a navigator push replacement to profile view
                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileView()
                                  ),
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
        _selectedDate = Timestamp.fromDate(pickedDate); // Mengubah kembali ke tipe Timestamp
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Update your profile',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Khusus untuk social media cukup masukkan username saja, tanpa link. Contoh: @username'')'),
                  TextFormField(
                    controller: _instagramController,
                    decoration: const InputDecoration(
                      labelText: 'Instagram',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _githubController,
                    decoration: const InputDecoration(
                      labelText: 'Github',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _linkedinController,
                    decoration: const InputDecoration(
                      labelText: 'LinkedIn',
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date of Birth',
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd MMM yyyy').format(_selectedDate?.toDate() ?? DateTime.now()),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateProfile,
                    child: const Text('Update'),
                  ),
                ],
              ),
            ),
            
    );
  }
}
