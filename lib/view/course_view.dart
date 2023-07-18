import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/course_viewmodel.dart';
import 'detailcourse_view.dart';

class CourseView extends StatefulWidget {
  final String courseType;
  const CourseView({Key? key, required this.courseType}) : super(key: key);

  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  final CourseViewModel _courseViewModel = Get.put(CourseViewModel());

  @override
  void initState() {
    super.initState();
    _courseViewModel.fetchCourses(widget.courseType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseType),
      ),
      body: Obx(
        () {
          if (_courseViewModel.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: [
              if (_courseViewModel.beginnerCourses.isNotEmpty)
                ListTile(
                  title: Text('Beginner'),
                  dense: true,
                ),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: _courseViewModel.beginnerCourses.length,
                itemBuilder: (context, index) {
                  final course = _courseViewModel.beginnerCourses[index];
                  return ListTile(
                    title: Text(course.title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailCourseView(
                            course: course,
                            courseType: widget.courseType,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(thickness: 3),
              if (_courseViewModel.intermediateCourses.isNotEmpty)
                ListTile(
                  title: Text('Intermediate'),
                  dense: true,
                ),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: _courseViewModel.intermediateCourses.length,
                itemBuilder: (context, index) {
                  final course = _courseViewModel.intermediateCourses[index];
                  return ListTile(
                    title: Text(course.title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailCourseView(
                            course: course,
                            courseType: widget.courseType,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(thickness: 3),
              if (_courseViewModel.advancedCourses.isNotEmpty)
                ListTile(
                  title: Text('Advanced'),
                  dense: true,
                ),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: _courseViewModel.advancedCourses.length,
                itemBuilder: (context, index) {
                  final course = _courseViewModel.advancedCourses[index];
                  return ListTile(
                    title: Text(course.title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailCourseView(
                            course: course,
                            courseType: widget.courseType,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(thickness: 3),
            ],
          );
        },
      ),
    );
  }
}
