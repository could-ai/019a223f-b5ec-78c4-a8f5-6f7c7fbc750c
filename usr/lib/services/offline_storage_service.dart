import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order.dart';
import '../models/product.dart';

class OfflineStorageService {
  static const String _draftOrdersKey = 'draft_orders';
  static const String _cachedProductsKey = 'cached_products';
  
  // Save draft order for offline mode
  static Future<void> saveDraftOrder(Order order) async {
    final prefs = await SharedPreferences.getInstance();
    final orderJson = order.toJson();
    final drafts = await getDraftOrders();
    drafts.add(orderJson);
    await prefs.setStringList(_draftOrdersKey, drafts.map((e) => e.toString()).toList());
  }
  
  // Get saved draft orders
  static Future<List<Map<String, dynamic>>> getDraftOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final drafts = prefs.getStringList(_draftOrdersKey) ?? [];
    return drafts.map((e) => Map<String, dynamic>.from({})).toList(); // Parse JSON
  }
  
  // Cache products for offline access
  static Future<void> cacheProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = products.map((p) => p.toJson()).toList();
    await prefs.setString(_cachedProductsKey, productsJson.toString());
  }
  
  // Get cached products
  static Future<List<Product>> getCachedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = prefs.getString(_cachedProductsKey);
    if (productsJson == null) return [];
    // Parse and return products
    return []; // Implement parsing
  }
  
  // Sync draft orders when online
  static Future<void> syncDraftOrders() async {
    final drafts = await getDraftOrders();
    // Send to server and clear local drafts
    // Implementation depends on API service
  }
  
  // Clear all cached data
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_draftOrdersKey);
    await prefs.remove(_cachedProductsKey);
  }
}
