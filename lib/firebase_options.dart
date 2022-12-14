// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  // static const FirebaseOptions web = FirebaseOptions(
  //   apiKey: 'AIzaSyD8cE5DYmND8NOgFTGIQpavvTJaGNSLMwE',
  //   appId: '1:65298134803:web:bb739b9a7517ccc8174ce6',
  //   messagingSenderId: '65298134803',
  //   projectId: 'firestore-uber',
  //   authDomain: 'firestore-uber.firebaseapp.com',
  //   storageBucket: 'firestore-uber.appspot.com',
  // );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZr9ayekw5WaqLqdXShxHebPR83WhmCPc',
    appId: '1:1076556903615:android:5fd947e9dc0342e111020a',
    messagingSenderId: '1076556903615',
    projectId: 'hyredriver-9ff34',
    storageBucket: 'com.hyre.passenger',
  );
}
