// ⚠️  ARQUIVO GERADO PELO FlutterFire CLI
// Execute os comandos abaixo para gerar este arquivo com suas credenciais reais:
//
//   dart pub global activate flutterfire_cli
//   flutterfire configure
//
// Substitua todo o conteúdo deste arquivo pelo arquivo gerado automaticamente.
// Documentação: https://firebase.flutter.dev/docs/cli

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions não está configurado para esta plataforma. '
          'Execute: flutterfire configure',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC5RSskLYD_bInV6erAk2qRSz5NYA7F7yA',
    appId: '1:566709013461:web:25462c59d24f0058de4b5c',
    messagingSenderId: '566709013461',
    projectId: 'multiterapia',
    authDomain: 'multiterapia.firebaseapp.com',
    storageBucket: 'multiterapia.firebasestorage.app',
    measurementId: 'G-5XYT50QTRD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAd-tVzWkx-CvkIUo6PHR5irObfaFl3xxQ',
    appId: '1:566709013461:android:c5bf46fc9b808d10de4b5c',
    messagingSenderId: '566709013461',
    projectId: 'multiterapia',
    storageBucket: 'multiterapia.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnUnvmvnlxC80YR9M_j7k2NJYYnOlBL6I',
    appId: '1:566709013461:ios:aef1868fb521147dde4b5c',
    messagingSenderId: '566709013461',
    projectId: 'multiterapia',
    storageBucket: 'multiterapia.firebasestorage.app',
    iosBundleId: 'com.multiterapia.multiterapia',
  );

}