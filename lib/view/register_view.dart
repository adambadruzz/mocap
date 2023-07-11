import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mocap/view/login_view.dart';
import 'package:mocap/viewmodel/register_viewmodel.dart';

import '../services/auth_service.dart';
import '../viewmodel/login_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class RegisterView extends StatefulWidget {
  final RegisterViewModel viewModel;

  RegisterView({required this.viewModel});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmpasswordController = TextEditingController();

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  late DateTime selectedDate;

  File? _selectedImage;

Future<void> _selectImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
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

  final Reference storageRef =
      FirebaseStorage.instance.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
  final UploadTask uploadTask = storageRef.putFile(_selectedImage!);
  final TaskSnapshot storageSnapshot = await uploadTask;
  final String downloadUrl = await storageSnapshot.ref.getDownloadURL();
  return downloadUrl;
}

  @override
    void initState() {
      super.initState();
      selectedDate = DateTime.now();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 20),
            Text('Welcome', style: TextStyle(fontSize: 20)),

            SizedBox(height: 20),
            Text("Let's create an account for you!",
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
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
                    ? Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password (Min 6 character)',
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: confirmpasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Fullname',
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'No. Handphone',
                ),
              ),
            ),
            
           Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Birthdate',
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd MMM yyyy').format(selectedDate),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
              ),

            SizedBox(height: 20),

            GestureDetector(
                onTap: () {
                  widget.viewModel.signUp(
                    email: emailController.text,
                    password: passwordController.text,
                    confirmpassword: confirmpasswordController.text,
                    nameController: nameController.text,
                    phoneController: phoneController.text,
                    selectedDate: selectedDate,
                    profileImage: _selectedImage,
                    context: context,
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )),
            SizedBox(height: 20),
            //register

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(child: Divider(color: Colors.black)),
                Text('Already have an account?',
                    style: TextStyle(fontSize: 15)),
                //register with text button color blue
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginView(
                                viewModel: LoginViewModel(
                                    authService: AuthService()))));
                  },
                  child: Text('Login', style: TextStyle(color: Colors.blue)),
                ),
                Expanded(child: Divider(color: Colors.black)),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
