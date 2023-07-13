import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../viewmodel/registergugle_viewmodel.dart';

class RegisterGoogleView extends StatefulWidget {
  final RegisterGoogleViewModel viewModel;

  const RegisterGoogleView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<RegisterGoogleView> createState() => _RegisterGoogleViewState();
}

class _RegisterGoogleViewState extends State<RegisterGoogleView> {

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
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery);
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

  if (selectedYear.isEmpty) {
    widget.viewModel.showErrorMessage(context, 'Please select the year of entry');
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
          child: Column(children: [
            const SizedBox(height: 20),
            const Text('Welcome', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            const Text("Let's create an account for you!",
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: DropdownButtonFormField<String>(
                value: selectedYear,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Angkatan',
                ),
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
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: asalController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Asal',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Birthdate',
                  ),
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
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (validateInputs()) {
                  widget.viewModel.signInWithGoogle(
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
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: const Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
          ]),
        ),
      ),
    );
  }
}