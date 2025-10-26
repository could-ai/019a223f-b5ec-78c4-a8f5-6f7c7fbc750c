import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../utils/app_constants.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _error;
  
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  final ApiService _apiService = ApiService();
  
  Future<bool> sendOtp(String phone) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await _apiService.sendOtp(phone);
      _isLoading = false;
      notifyListeners();
      return response['success'] ?? false;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  Future<bool> verifyOtp(String phone, String otp) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await _apiService.verifyOtp(phone, otp);
      if (response['success'] == true) {
        _currentUser = User.fromJson(response['user']);
        // Store token
        // await _storeToken(response['token']);
      }
      _isLoading = false;
      notifyListeners();
      return response['success'] ?? false;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  void logout() {
    _currentUser = null;
    // Clear stored token
    notifyListeners();
  }
  
  bool get isAuthenticated => _currentUser != null;
  bool get isSR => _currentUser?.role == AppConstants.roleSR;
  bool get isDealer => _currentUser?.role == AppConstants.roleDealer;
}
