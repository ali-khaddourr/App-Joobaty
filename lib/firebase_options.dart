// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCToQLNetlwALLh9AX4ZiFAV9AlRcv7pqc',
    appId: '1:219890837484:web:1f436229843ca03c27c2c9',
    messagingSenderId: '219890837484',
    projectId: 'joobaty-1a5f3',
    authDomain: 'joobaty-1a5f3.firebaseapp.com',
    storageBucket: 'joobaty-1a5f3.appspot.com',
    measurementId: 'G-34HE3E075D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDaI_JtlVIr77UVTkb8lUzdsVT1q0hT_6I',
    appId: '1:219890837484:android:7a4d42ecd361915f27c2c9',
    messagingSenderId: '219890837484',
    projectId: 'joobaty-1a5f3',
    storageBucket: 'joobaty-1a5f3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8lRRiXvhdGLABlD2WdT4RL4I0erDUeLM',
    appId: '1:219890837484:ios:46dea4df88a659ee27c2c9',
    messagingSenderId: '219890837484',
    projectId: 'joobaty-1a5f3',
    storageBucket: 'joobaty-1a5f3.appspot.com',
    iosBundleId: 'com.example.joobaty',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC8lRRiXvhdGLABlD2WdT4RL4I0erDUeLM',
    appId: '1:219890837484:ios:46dea4df88a659ee27c2c9',
    messagingSenderId: '219890837484',
    projectId: 'joobaty-1a5f3',
    storageBucket: 'joobaty-1a5f3.appspot.com',
    iosBundleId: 'com.example.joobaty',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCToQLNetlwALLh9AX4ZiFAV9AlRcv7pqc',
    appId: '1:219890837484:web:c9a8e38f70079ce727c2c9',
    messagingSenderId: '219890837484',
    projectId: 'joobaty-1a5f3',
    authDomain: 'joobaty-1a5f3.firebaseapp.com',
    storageBucket: 'joobaty-1a5f3.appspot.com',
    measurementId: 'G-D0XP5RDE8W',
  );
}
