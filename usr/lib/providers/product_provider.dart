import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;
  
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  final ApiService _apiService = ApiService();
  
  Future<void> loadProducts(String areaId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await _apiService.getProducts(areaId);
      _products = response.map<Product>((json) => Product.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Cache products for offline mode
  Future<void> cacheProducts() async {
    // Implementation for caching products locally
  }
  
  Future<void> loadCachedProducts() async {
    // Implementation for loading cached products
  }
}
