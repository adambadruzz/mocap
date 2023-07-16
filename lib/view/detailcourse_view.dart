import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/course_model.dart';

class DetailCourseView extends StatelessWidget {
  final CourseModel course;

  DetailCourseView({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: course.linkYoutube,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Scaffold(
      appBar: AppBar(),
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
              Text(course.title,
                style: const TextStyle(
                  fontSize: 18,
                ),),
              const SizedBox(height: 10),
              const Text(
                'Tingkatan:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(course.tingkatan,
                style: const TextStyle(
                  fontSize: 18,
                ),),
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
