import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/api_service.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  Order? _currentOrder;
  bool _isLoading = false;
  String? _error;
  
  List<Order> get orders => _orders;
  Order? get currentOrder => _currentOrder;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  final ApiService _apiService = ApiService();
  
  void startNewOrder() {
    _currentOrder = Order.empty();
    notifyListeners();
  }
  
  void addItemToOrder(OrderItem item) {
    if (_currentOrder != null) {
      _currentOrder!.items.add(item);
      _currentOrder!.calculateTotal();
      notifyListeners();
    }
  }
  
  void removeItemFromOrder(int index) {
    if (_currentOrder != null && index < _currentOrder!.items.length) {
      _currentOrder!.items.removeAt(index);
      _currentOrder!.calculateTotal();
      notifyListeners();
    }
  }
  
  void updateItemQuantity(int index, int quantity) {
    if (_currentOrder != null && index < _currentOrder!.items.length) {
      _currentOrder!.items[index].quantity = quantity;
      _currentOrder!.calculateTotal();
      notifyListeners();
    }
  }
  
  void applyDiscount(double discount) {
    if (_currentOrder != null) {
      _currentOrder!.discount = discount;
      _currentOrder!.calculateTotal();
      notifyListeners();
    }
  }
  
  Future<bool> submitOrder() async {
    if (_currentOrder == null) return false;
    
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await _apiService.createOrder(_currentOrder!.toJson());
      _orders.add(Order.fromJson(response));
      _currentOrder = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  Future<void> loadOrders() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final response = await _apiService.getOrders();
      _orders = response.map<Order>((json) => Order.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
  
  // Save draft order for offline mode
  Future<void> saveDraftOrder() async {
    // Implementation for saving draft locally
  }
  
  // Sync draft orders when online
  Future<void> syncDraftOrders() async {
    // Implementation for syncing drafts
  }
}
