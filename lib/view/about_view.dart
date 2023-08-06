import 'package:flutter/material.dart';
import 'package:mocap/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  Future<void> _launchUrl(String? url) async {
    if (await canLaunch(url!)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'About this App',
          style: headline2,
        ),
        leading: null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(paddingL),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(78, 0, 78, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Image.asset(
                "assets/images/illus_mocap2.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Introducing the Mobile Mocap Community App, where you can dive into the world of mobile programming, learn through curated courses, connect with like-minded members, and explore a vibrant community.\n\n'
              '⬛ EXPLORE COURSES: Unlock your potential with our comprehensive courses designed to enhance your mobile programming skills. From beginner-friendly introductions to advanced topics, our courses cover everything you need to know about mobile development using Flutter and VSCode.\n\n'
              '⬛ PERSONALIZED PROFILES: Create your unique profile and showcase your mobile programming journey. Customize your bio, highlight your skills, and connect with other members who share your passion for mobile development. Let your profile reflect your expertise and attract like-minded individuals.\n\n'
              '⬛ CONNECT & COLLABORATE: Engage in discussions, share ideas, and collaborate with fellow members. Whether you\'re seeking advice, looking for a programming partner, or simply want to connect with others in the community, our app provides a platform for networking and collaboration.\n\n'
              '⬛ ORGANIZATIONAL STRUCTURE: Gain insights into the Mobile Mocap Community\'s organizational structure. Explore the different teams and divisions that make up our community, understand their roles, and connect with key contributors. Get a deeper understanding of our community\'s inner workings.\n\n'
              '⬛ POST AND SHARE: Express yourself through posts, updates, and discussions. Share your progress, ask questions, and seek feedback from the community. It\'s your platform to share your projects, code snippets, and insights, while also staying updated on the latest trends and developments in the mobile programming world.\n\n'
              '⬛ STAY IN THE LOOP: Receive notifications about course updates, community events, and important announcements. Be the first to know about new learning resources, upcoming workshops, and exciting opportunities within the Mobile Mocap Community.\n\n'
              'Embark on your mobile programming journey with the Mobile Mocap Community App. Join a thriving community, expand your knowledge through courses, connect with fellow developers, and unleash your full potential in the world of mobile programming. Let\'s learn, collaborate, and create together!\n\n'
              'Don’t forget to connect with us',
              style: paragraphRegular,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    const linkedinUrl =
                        'https://www.linkedin.com/company/mobile-community-all-platform-mocap/';
                    _launchUrl(linkedinUrl);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                    backgroundColor: lightGreen, // <-- Button color
                    foregroundColor: blueFigma, // <-- Splash color
                  ),
                  child:
                      const Icon(FontAwesomeIcons.linkedin, color: blueFigma),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                    backgroundColor: lightGreen, // <-- Button color
                    foregroundColor: blueFigma, // <-- Splash color
                  ),
                  child: const Icon(Icons.mail_outline, color: blueFigma),
                ),
                ElevatedButton(
                  onPressed: () {
                    const instagramUrl =
                        'https://www.instagram.com/mobilemocap';
                    _launchUrl(instagramUrl);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                    backgroundColor: lightGreen, // <-- Button color
                    foregroundColor: blueFigma, // <-- Splash color
                  ),
                  child:
                      const Icon(FontAwesomeIcons.instagram, color: blueFigma),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'MOCAP COMMUNITY APP',
              style: headline3,
            ),
            const SizedBox(height: 6),
            const Text(
              'v1.0',
              style: paragraph,
            ),
            const SizedBox(height: 6),
            const CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/logo_mocap.png",
              ),
              radius: 30,
            ),
            const SizedBox(height: 6),
            const Text(
              '2023',
              style: headline3,
            ),
          ],
        ),
      ),
    );
  }
}
