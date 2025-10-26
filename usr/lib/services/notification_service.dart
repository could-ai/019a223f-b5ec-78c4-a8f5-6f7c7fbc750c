import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  
  Future<void> initialize() async {
    // Request permission for notifications
    await _firebaseMessaging.requestPermission();
    
    // Initialize local notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();
    const InitializationSettings settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    
    await _flutterLocalNotificationsPlugin.initialize(settings);
    
    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // Get FCM token
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
  }
  
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails('channel_id', 'channel_name');
    const NotificationDetails details =
        NotificationDetails(android: androidDetails);
    
    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      details,
    );
  }
  
  Future<void> showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails('local_channel', 'Local Notifications');
    const NotificationDetails details =
        NotificationDetails(android: androidDetails);
    
    await _flutterLocalNotificationsPlugin.show(1, title, body, details);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling background message: ${message.messageId}');
}
