import '../models/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailCourseViewModel {
  final CourseModel course;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DetailCourseViewModel({required this.course});

  Future<bool> isAdmin() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final uid = user.uid;
      final userDoc = _firestore.collection('users').doc(uid);
      final snapshot = await userDoc.get();
      final userData = snapshot.data() as Map<String, dynamic>;
      final specialRole = userData['specialrole'];
      return specialRole == 'admin';
    }
    return false;
  }

  Future<void> deleteCourse(String courseType) async {
    try {
      final courseCollection = _firestore.collection(courseType);
      await courseCollection.doc(course.id).delete();
    } catch (e) {
      throw Exception('Failed to delete course');
    }
  }
}
