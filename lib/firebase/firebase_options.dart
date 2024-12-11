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
    apiKey: 'AIzaSyA3Wg47RaFBnlm14xsFKKxPZmVMVDNUbt0',
    appId: '1:556558246182:web:a4d4e01e3cf910b27ee1e7',
    messagingSenderId: '556558246182',
    projectId: 'athlete-aware-76cc1',
    authDomain: 'athlete-aware-76cc1.firebaseapp.com',
    storageBucket: 'athlete-aware-76cc1.firebasestorage.app',
    measurementId: 'G-MJP9ZX7D3Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAcmpjSDaNuq_nutpH8Axp8F1x6lzi8DrI',
    appId: '1:556558246182:android:2d288a1070dbbabc7ee1e7',
    messagingSenderId: '556558246182',
    projectId: 'athlete-aware-76cc1',
    storageBucket: 'athlete-aware-76cc1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzFSHCRXSjBFLvJ9GXkC8mLsdQd66gpU4',
    appId: '1:556558246182:ios:5b92cdd014c90b117ee1e7',
    messagingSenderId: '556558246182',
    projectId: 'athlete-aware-76cc1',
    storageBucket: 'athlete-aware-76cc1.firebasestorage.app',
    iosBundleId: 'com.example.athleteAware',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzFSHCRXSjBFLvJ9GXkC8mLsdQd66gpU4',
    appId: '1:556558246182:ios:5b92cdd014c90b117ee1e7',
    messagingSenderId: '556558246182',
    projectId: 'athlete-aware-76cc1',
    storageBucket: 'athlete-aware-76cc1.firebasestorage.app',
    iosBundleId: 'com.example.athleteAware',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA3Wg47RaFBnlm14xsFKKxPZmVMVDNUbt0',
    appId: '1:556558246182:web:939024828eb5c7447ee1e7',
    messagingSenderId: '556558246182',
    projectId: 'athlete-aware-76cc1',
    authDomain: 'athlete-aware-76cc1.firebaseapp.com',
    storageBucket: 'athlete-aware-76cc1.firebasestorage.app',
    measurementId: 'G-25K8RJR9N3',
  );
}
