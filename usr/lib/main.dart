import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/auth_provider.dart';
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
  await NotificationService().initialize();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/dealer_dashboard': (context) => const DealerDashboardScreen(),
        '/visit_list': (context) => const VisitListScreen(),
        '/create_order': (context) => const CreateOrderScreen(),
        '/dealer_create_order': (context) => const DealerCreateOrderScreen(),
        '/order_review': (context) => const OrderReviewScreen(),
        '/order_success': (context) => const OrderSuccessScreen(),
        '/orders_history': (context) => const OrdersHistoryScreen(),
        '/invoice_history': (context) => const InvoiceHistoryScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/catalog': (context) => const CatalogScreen(),
        '/payment_options': (context) => const PaymentOptionsScreen(),
        '/map': (context) => const MapScreen(),
      },
    );
  }
}
