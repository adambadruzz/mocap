import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/createcourse_viewmodel.dart';

class CreateCourseView extends StatelessWidget {
  final CreateCourseViewModel viewModel = Get.put(CreateCourseViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Course'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: CourseForm(),
      ),
    );
  }
}

class CourseForm extends StatelessWidget {
  final CreateCourseViewModel viewModel = Get.find();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _youtubeLinkController = TextEditingController();
  String _selectedLevel = 'Beginner';
  String _selectedProgrammingLanguage = 'Flutter';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
            onChanged: (value) {
              viewModel.setTitle(value);
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              viewModel.setDescription(value);
            },
          ),
          SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: _selectedLevel,
            decoration: InputDecoration(labelText: 'Level'),
            onChanged: (String? newValue) {
              if (newValue != null) {
                _selectedLevel = newValue;
                viewModel.setSelectedLevel(newValue);
              }
            },
            items: <String>['Beginner', 'Intermediate', 'Advanced']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: _selectedProgrammingLanguage,
            decoration: InputDecoration(labelText: 'Programming Language'),
            onChanged: (String? newValue) {
              if (newValue != null) {
                _selectedProgrammingLanguage = newValue;
                viewModel.setSelectedProgrammingLanguage(newValue);
              }
            },
            items: <String>['Flutter', 'Kotlin', 'Java', 'JavaScript']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _youtubeLinkController,
            decoration: InputDecoration(labelText: 'YouTube Video ID'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a YouTube Video ID';
              }
              return null;
            },
            onChanged: (value) {
              viewModel.setYoutubeLink(value);
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty &&
                  _youtubeLinkController.text.isNotEmpty) {
                viewModel.createCourse(
                  _selectedLevel,
                  _selectedProgrammingLanguage,
                );
              }
            },
            child: Text('Create Course'),
          ),
        ],
      ),
    );
  }
}
