import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/course_model.dart';
import '../viewmodel/navbar_viewmodel.dart';
import 'navbar_view.dart';

class DetailCourseView extends StatelessWidget {
  final CourseModel course;
  final NavigationBarViewModel _navBarViewModel = NavigationBarViewModel();

  DetailCourseView({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: course.linkYoutube,
      flags: YoutubePlayerFlags(
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
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
              ),
              SizedBox(height: 16),
              Text(
                'Title:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(course.title,
                style: TextStyle(
                  fontSize: 18,
                ),),
              SizedBox(height: 10),
              Text(
                'Tingkatan:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(course.tingkatan,
                style: TextStyle(
                  fontSize: 18,
                ),),
              SizedBox(height: 16),
              if (course.description != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(course.description!),
                  ],
                ),
            ],
          ),
        ),
      ),
      
    );
  }
}
