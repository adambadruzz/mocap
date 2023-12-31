// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB_Kc01AiXRHCpO1aFECnqO3XWG89Fffbg',
    appId: '1:940417655277:web:4ee60e16dc62f4d77807e4',
    messagingSenderId: '940417655277',
    projectId: 'mocap-app-2328a',
    authDomain: 'mocap-app-2328a.firebaseapp.com',
    storageBucket: 'mocap-app-2328a.appspot.com',
    measurementId: 'G-FTCQXYHP9B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDInaiOKPm3ETblZGhm_Rd2Ksbdi275qTs',
    appId: '1:940417655277:android:42382f2fd604bc757807e4',
    messagingSenderId: '940417655277',
    projectId: 'mocap-app-2328a',
    storageBucket: 'mocap-app-2328a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqH-Fy6lR198t3HPXvEdkXBLaqZrQs_y8',
    appId: '1:940417655277:ios:6e02669a174b51bd7807e4',
    messagingSenderId: '940417655277',
    projectId: 'mocap-app-2328a',
    storageBucket: 'mocap-app-2328a.appspot.com',
    iosClientId: '940417655277-1pdho3aavthlu8d9ossn3gu0s0cciesk.apps.googleusercontent.com',
    iosBundleId: 'com.example.mocap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAqH-Fy6lR198t3HPXvEdkXBLaqZrQs_y8',
    appId: '1:940417655277:ios:458b7d5717031a3e7807e4',
    messagingSenderId: '940417655277',
    projectId: 'mocap-app-2328a',
    storageBucket: 'mocap-app-2328a.appspot.com',
    iosClientId: '940417655277-l75hgq0ia4j8r8l1qaqvm9f794oqunj7.apps.googleusercontent.com',
    iosBundleId: 'com.example.mocap.RunnerTests',
  );
}
