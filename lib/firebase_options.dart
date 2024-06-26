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
    apiKey: 'AIzaSyBfMe5gHu6KxQRpSBm4SITWPiprQ5T-9PE',
    appId: '1:1084366066638:web:a9f8230cde5f471573d19f',
    messagingSenderId: '1084366066638',
    projectId: 'chat-21c9c',
    authDomain: 'chat-21c9c.firebaseapp.com',
    storageBucket: 'chat-21c9c.appspot.com',
    measurementId: 'G-0NBHBZ0GD7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAoFSvTABWeShUqE8q7kB3FIEMWehG8lLE',
    appId: '1:1084366066638:android:bc1b686f30cf40c773d19f',
    messagingSenderId: '1084366066638',
    projectId: 'chat-21c9c',
    storageBucket: 'chat-21c9c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcJwrhCKF4cOnIuMQ_7RZEa7FkI_KP6Oc',
    appId: '1:1084366066638:ios:67be4d1929becee573d19f',
    messagingSenderId: '1084366066638',
    projectId: 'chat-21c9c',
    storageBucket: 'chat-21c9c.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDcJwrhCKF4cOnIuMQ_7RZEa7FkI_KP6Oc',
    appId: '1:1084366066638:ios:67be4d1929becee573d19f',
    messagingSenderId: '1084366066638',
    projectId: 'chat-21c9c',
    storageBucket: 'chat-21c9c.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBfMe5gHu6KxQRpSBm4SITWPiprQ5T-9PE',
    appId: '1:1084366066638:web:9e33571d8199cada73d19f',
    messagingSenderId: '1084366066638',
    projectId: 'chat-21c9c',
    authDomain: 'chat-21c9c.firebaseapp.com',
    storageBucket: 'chat-21c9c.appspot.com',
    measurementId: 'G-G550LPH4F8',
  );

}