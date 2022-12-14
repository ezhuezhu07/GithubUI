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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAHitDCct-T19m0-z17aEwEv8qa40-meYE',
    appId: '1:230959181582:web:daa842d976060f3a98315f',
    messagingSenderId: '230959181582',
    projectId: 'github-clone-eebd3',
    authDomain: 'github-clone-eebd3.firebaseapp.com',
    storageBucket: 'github-clone-eebd3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDSNGnFOcJFuO5a13_QcieKMvdA4CnN9M',
    appId: '1:230959181582:android:b5e76038491aa6b398315f',
    messagingSenderId: '230959181582',
    projectId: 'github-clone-eebd3',
    storageBucket: 'github-clone-eebd3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAU9e84LV2VaYUSBUNh1yd-7oQuEwvQn9w',
    appId: '1:230959181582:ios:77f5b65b9630dbca98315f',
    messagingSenderId: '230959181582',
    projectId: 'github-clone-eebd3',
    storageBucket: 'github-clone-eebd3.appspot.com',
    iosClientId: '230959181582-72q97u112s4nioj44jpi1aatjri8gf02.apps.googleusercontent.com',
    iosBundleId: 'com.example.githubClone',
  );
}
