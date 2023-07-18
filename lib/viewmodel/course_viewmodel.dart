import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/course_model.dart';

class CourseViewModel extends GetxController {
  RxList<CourseModel> beginnerCourses = <CourseModel>[].obs;
  RxList<CourseModel> intermediateCourses = <CourseModel>[].obs;
  RxList<CourseModel> advancedCourses = <CourseModel>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchCourses(String courseType) async {
    try {
      isLoading.value = true;

      final beginnerCourses = await getCoursesByTypeAndLevel(courseType, 'Beginner');
      final intermediateCourses = await getCoursesByTypeAndLevel(courseType, 'Intermediate');
      final advancedCourses = await getCoursesByTypeAndLevel(courseType, 'Advanced');

      this.beginnerCourses.value = beginnerCourses;
      this.intermediateCourses.value = intermediateCourses;
      this.advancedCourses.value = advancedCourses;
    } catch (e) {
      // Tangani kesalahan atau lanjutkan dengan eksekusi program lanjutan
      print('Error fetching courses: $e');
      // Tambahkan kode yang ingin dieksekusi setelah penanganan kesalahan
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<CourseModel>> getCoursesByTypeAndLevel(String courseType, String level) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(courseType)
        .where('tingkatan', isEqualTo: level)
        .orderBy('index')
        .get();

    final List<CourseModel> courses = querySnapshot.docs.map((doc) => CourseModel.fromSnapshot(doc)).toList();

    return courses;
  }
}
