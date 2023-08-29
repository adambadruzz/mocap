import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';
import 'package:mocap/global_widgets/app_bar.dart';
import 'package:mocap/global_widgets/item_course.dart';
import '../models/course_model.dart';
import '../viewmodel/course_viewmodel.dart';

class CourseView extends StatefulWidget {
  final String courseType;
  const CourseView({Key? key, required this.courseType}) : super(key: key);

  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  final CourseViewModel _courseViewModel = CourseViewModel();
  List<CourseModel> _beginnerCourses = [];
  List<CourseModel> _intermediateCourses = [];
  List<CourseModel> _advancedCourses = [];

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    final beginnerCourses = await _courseViewModel.getCoursesByTypeAndLevel(
        widget.courseType, 'Beginner');
    final intermediateCourses = await _courseViewModel.getCoursesByTypeAndLevel(
        widget.courseType, 'Intermediate');
    final advancedCourses = await _courseViewModel.getCoursesByTypeAndLevel(
        widget.courseType, 'Advanced');

    setState(() {
      _beginnerCourses = beginnerCourses;
      _intermediateCourses = intermediateCourses;
      _advancedCourses = advancedCourses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(widget.courseType),
        body: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey.shade300)),
                  ),
                  child: const TabBar(
                    labelColor: black, // Mengubah warna teks menjadi hitam
                    indicatorColor: blueFigma,
                    tabs: [
                      Tab(text: 'Beginner'),
                      Tab(text: 'Intermediate'),
                      Tab(text: 'Advanced'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      itemCourse(_beginnerCourses.length, _beginnerCourses, widget.courseType),
                      itemCourse(_intermediateCourses.length, _intermediateCourses, widget.courseType),
                      itemCourse(_advancedCourses.length, _advancedCourses, widget.courseType),
                    ],
                  ),
                )
              ],
            ))
        );
  }
}
