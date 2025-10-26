import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConfig {
  // Firebase configuration for Android
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'your_api_key',
    appId: 'your_app_id',
    messagingSenderId: 'your_sender_id',
    projectId: 'your_project_id',
  );
  
  // Firebase configuration for iOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your_api_key',
    appId: 'your_app_id',
    messagingSenderId: 'your_sender_id',
    projectId: 'your_project_id',
  );
}
