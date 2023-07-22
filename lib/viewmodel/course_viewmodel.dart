import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course_model.dart';

class CourseViewModel {
  Future<List<CourseModel>> getCoursesByTypeAndLevel(String courseType, String level) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(courseType)
        .where('tingkatan', isEqualTo: level)
        .orderBy('index')
        .get();

    final List<CourseModel> courses = querySnapshot.docs
        .map((doc) => CourseModel.fromSnapshot(doc))
        .toList();

    return courses;
  }
}
