import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class DefaultFirebaseOptions {
  static firebase_core.FirebaseOptions get currentPlatform {
    // For now, return android options; adjust for platform if needed
    return android;
  }

  static const firebase_core.FirebaseOptions android = firebase_core.FirebaseOptions(
    apiKey: 'your_api_key',
    appId: 'your_app_id',
    messagingSenderId: 'your_sender_id',
    projectId: 'your_project_id',
  );

  static const firebase_core.FirebaseOptions ios = firebase_core.FirebaseOptions(
    apiKey: 'your_api_key',
    appId: 'your_app_id',
    messagingSenderId: 'your_sender_id',
    projectId: 'your_project_id',
  );
}