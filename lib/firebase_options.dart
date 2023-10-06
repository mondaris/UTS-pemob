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
    apiKey: 'AIzaSyBGxgM3jVRDhCDQlPkQrrBr3-a6V1STnLs',
    appId: '1:1060219606030:web:8e6ecae5ffd4cfd4da585f',
    messagingSenderId: '1060219606030',
    projectId: 'cobafire-b9df9',
    authDomain: 'cobafire-b9df9.firebaseapp.com',
    storageBucket: 'cobafire-b9df9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqavkzc0EJwNgys939y1QZSLEnBf0yAww',
    appId: '1:1060219606030:android:33d51d3718f1514cda585f',
    messagingSenderId: '1060219606030',
    projectId: 'cobafire-b9df9',
    storageBucket: 'cobafire-b9df9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOVqBgh_ILUhl3NIi8owIu5amb029nGB4',
    appId: '1:1060219606030:ios:0f1caf2217e3ca7dda585f',
    messagingSenderId: '1060219606030',
    projectId: 'cobafire-b9df9',
    storageBucket: 'cobafire-b9df9.appspot.com',
    iosBundleId: 'com.example.coba',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCOVqBgh_ILUhl3NIi8owIu5amb029nGB4',
    appId: '1:1060219606030:ios:8cfa17055b652057da585f',
    messagingSenderId: '1060219606030',
    projectId: 'cobafire-b9df9',
    storageBucket: 'cobafire-b9df9.appspot.com',
    iosBundleId: 'com.example.coba.RunnerTests',
  );
}
