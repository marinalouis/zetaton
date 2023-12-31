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
    apiKey: 'AIzaSyAYghRmbfoKXAxlTjI195YrVeBMy16uA1U',
    appId: '1:908546722113:web:004cf2a25993eac51bf9c0',
    messagingSenderId: '908546722113',
    projectId: 'zetaton-ce3cc',
    authDomain: 'zetaton-ce3cc.firebaseapp.com',
    storageBucket: 'zetaton-ce3cc.appspot.com',
    measurementId: 'G-5JW74NEE5Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCo-Y917v84IvtBDBulc6HOjl-5OcVb0x8',
    appId: '1:908546722113:android:32dff43f40036a5d1bf9c0',
    messagingSenderId: '908546722113',
    projectId: 'zetaton-ce3cc',
    storageBucket: 'zetaton-ce3cc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwRYhkBAtRNCZDlvfDxBm4AhGzoUUJqrc',
    appId: '1:908546722113:ios:fd3876f6228df32d1bf9c0',
    messagingSenderId: '908546722113',
    projectId: 'zetaton-ce3cc',
    storageBucket: 'zetaton-ce3cc.appspot.com',
    iosBundleId: 'com.company.zetaton',
  );
}
