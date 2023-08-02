import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/course_model.dart';
import '../viewmodel/coursemenu_viewmodel.dart';
import '../viewmodel/detailcourse_viewmodel.dart';
import 'coursemenu_view.dart';

class DetailCourseView extends StatelessWidget {
  final CourseModel course;
  final String courseType;

  const DetailCourseView({Key? key, required this.course, required this.courseType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = DetailCourseViewModel(course: course);

    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: course.linkYoutube,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          FutureBuilder<bool>(
            future: viewModel.isAdmin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              if (snapshot.hasData && snapshot.data!) {
                return IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Course'),
                          content: const Text('Are you sure you want to delete this course?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                //create me a navigator push replacement to coursemenu
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => CourseMenuView(viewModel: CourseMenuViewModel(context: context))),
                                );
                                
                              },
                            ),
                            TextButton(
                              child: const Text('Delete'),
                              onPressed: () async {
                                await viewModel.deleteCourse(courseType);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
              ),
              const SizedBox(height: 16),
              const Text(
                'Title:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                course.title,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Tingkatan:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                course.tingkatan,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              if (course.description != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(course.description),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
