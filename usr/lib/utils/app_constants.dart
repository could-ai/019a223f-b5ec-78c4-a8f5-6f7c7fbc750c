class AppConstants {
  static const String appName = 'SR & Dealer App';
  static const String baseUrl = 'https://api.srdealer.com'; // Replace with actual backend URL
  
  // User roles
  static const String roleAdmin = 'admin';
  static const String roleSR = 'sr';
  static const String roleDealer = 'dealer';
  
  // Order statuses
  static const String orderStatusPending = 'Pending';
  static const String orderStatusPacked = 'Packed';
  static const String orderStatusDispatched = 'Dispatched';
  static const String orderStatusDelivered = 'Delivered';
  
  // Payment statuses
  static const String paymentStatusPending = 'Pending';
  static const String paymentStatusCompleted = 'Completed';
  static const String paymentStatusFailed = 'Failed';
  
  // API endpoints
  static const String sendOtpEndpoint = '/auth/send-otp';
  static const String verifyOtpEndpoint = '/auth/verify-otp';
  static const String productsEndpoint = '/products';
  static const String ordersEndpoint = '/orders';
  static const String reportsEndpoint = '/reports';
  static const String paymentsEndpoint = '/payments';
}
