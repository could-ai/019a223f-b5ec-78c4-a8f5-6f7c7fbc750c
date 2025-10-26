import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/auth_provider.dart' as app_auth;
import 'providers/order_provider.dart';
import 'providers/product_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/dealer_dashboard_screen.dart';
import 'screens/visit_list_screen.dart';
import 'screens/create_order_screen.dart';
import 'screens/dealer_create_order_screen.dart';
import 'screens/order_review_screen.dart';
import 'screens/order_success_screen.dart';
import 'screens/orders_history_screen.dart';
import 'screens/invoice_history_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/payment_options_screen.dart';
import 'screens/map_screen.dart';
import 'services/notification_service.dart';
import 'utils/app_constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize SharedPreferences for offline data
  final prefs = await SharedPreferences.getInstance();
  
  // Initialize notification service
  // await NotificationService().initialize(); // Commented out due to package resolution issue
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => app_auth.AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: const MyApp(),
    ),
  );
}