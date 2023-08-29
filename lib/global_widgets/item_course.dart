import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';
import 'package:mocap/models/course_model.dart';
import 'package:mocap/view/detailcourse_view.dart';

Widget itemCourse(int length, List<CourseModel> _course, String courseType) {
  return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1),
              shrinkWrap: true,
              itemCount: length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final course = _course[index];
                return InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                              image: NetworkImage(
                                "https://englishtoday.co.id/wp-content/uploads/2022/03/There-are-lots-of-English-courses-so-you-can-choose-a-trusted-one.png",
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: paddingM),
                      Text(course.title, style: headline3),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailCourseView(
                          course: course,
                          courseType: courseType,
                        ),
                      ),
                    );
                  },
                );
              })));
}
