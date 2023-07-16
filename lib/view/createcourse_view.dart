import 'package:flutter/material.dart';
import '../viewmodel/createcourse_viewmodel.dart';

class CreateCourseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = CreateCourseViewModel(context: context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Course'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: CourseForm(viewModel: viewModel),
      ),
    );
  }
}

class CourseForm extends StatefulWidget {
  final CreateCourseViewModel viewModel;

  CourseForm({required this.viewModel});

  @override
  _CourseFormState createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
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
              widget.viewModel.setTitle(value);
            },
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              widget.viewModel.setDescription(value);
            },
          ),
          SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: _selectedLevel,
            decoration: InputDecoration(labelText: 'Level'),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedLevel = newValue;
                  widget.viewModel.setSelectedLevel(newValue);
                });
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
                setState(() {
                  _selectedProgrammingLanguage = newValue;
                  widget.viewModel.setSelectedProgrammingLanguage(newValue);
                });
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
              widget.viewModel.setYoutubeLink(value);
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty &&
                  _youtubeLinkController.text.isNotEmpty) {
                widget.viewModel.createCourse(
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
