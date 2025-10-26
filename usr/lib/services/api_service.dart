import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_constants.dart';

class ApiService {
  final String baseUrl = AppConstants.baseUrl;
  
  Future<Map<String, dynamic>> sendOtp(String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl${AppConstants.sendOtpEndpoint}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );
    return jsonDecode(response.body);
  }
  
  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final response = await http.post(
      Uri.parse('$baseUrl${AppConstants.verifyOtpEndpoint}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'otp': otp}),
    );
    return jsonDecode(response.body);
  }
  
  Future<List<dynamic>> getProducts(String areaId) async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl${AppConstants.productsEndpoint}?area_id=$areaId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return jsonDecode(response.body);
  }
  
  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl${AppConstants.ordersEndpoint}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(orderData),
    );
    return jsonDecode(response.body);
  }
  
  Future<List<dynamic>> getOrders() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl${AppConstants.ordersEndpoint}'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return jsonDecode(response.body);
  }
  
  Future<Map<String, dynamic>> getSrPerformance(String from, String to) async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl${AppConstants.reportsEndpoint}/sr-performance?from=$from&to=$to'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return jsonDecode(response.body);
  }
  
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
