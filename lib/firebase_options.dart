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
    apiKey: 'AIzaSyCNMj-PuyLbtCZtMe9HXZexaG1XXKet1SI',
    appId: '1:150725071013:web:02bb1c7991a7bf7efabd4c',
    messagingSenderId: '150725071013',
    projectId: 'flutterapp-8992c',
    authDomain: 'flutterapp-8992c.firebaseapp.com',
    storageBucket: 'flutterapp-8992c.firebasestorage.app',
    measurementId: 'G-5KMGTF91KL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCut8T6NpVUF1Lcraxh1YqybYx0z1GrOBE',
    appId: '1:150725071013:android:e2744b08ee7540f9fabd4c',
    messagingSenderId: '150725071013',
    projectId: 'flutterapp-8992c',
    storageBucket: 'flutterapp-8992c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCsTbiwSfeEsrRWbmPWcg7o_ia1Oe46ulw',
    appId: '1:150725071013:ios:441f7b670e94a614fabd4c',
    messagingSenderId: '150725071013',
    projectId: 'flutterapp-8992c',
    storageBucket: 'flutterapp-8992c.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCsTbiwSfeEsrRWbmPWcg7o_ia1Oe46ulw',
    appId: '1:150725071013:ios:441f7b670e94a614fabd4c',
    messagingSenderId: '150725071013',
    projectId: 'flutterapp-8992c',
    storageBucket: 'flutterapp-8992c.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCNMj-PuyLbtCZtMe9HXZexaG1XXKet1SI',
    appId: '1:150725071013:web:fa9aa67c2233d7e3fabd4c',
    messagingSenderId: '150725071013',
    projectId: 'flutterapp-8992c',
    authDomain: 'flutterapp-8992c.firebaseapp.com',
    storageBucket: 'flutterapp-8992c.firebasestorage.app',
    measurementId: 'G-CMGTTPDWFJ',
  );

}