import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/product.dart';

class MockData {
  static List<Product> getMockProducts() {
    return [
      Product(
        id: '1',
        sku: 'PROD001',
        name: 'Wireless Mouse',
        price: 500.0,
        mrp: 600.0,
        unit: 'pcs',
        stockByWarehouse: {'warehouse1': 100, 'warehouse2': 50},
        images: ['https://example.com/mouse.jpg'],
      ),
      Product(
        id: '2',
        sku: 'PROD002',
        name: 'Bluetooth Keyboard',
        price: 1200.0,
        mrp: 1500.0,
        unit: 'pcs',
        stockByWarehouse: {'warehouse1': 75, 'warehouse2': 25},
        images: ['https://example.com/keyboard.jpg'],
      ),
      Product(
        id: '3',
        sku: 'PROD003',
        name: 'USB Cable',
        price: 100.0,
        mrp: 120.0,
        unit: 'pcs',
        stockByWarehouse: {'warehouse1': 200, 'warehouse2': 150},
        images: ['https://example.com/cable.jpg'],
      ),
    ];
  }
  
  static List<Order> getMockOrders() {
    return [
      Order(
        id: 'ORD001',
        dealerId: 'dealer1',
        srId: 'sr1',
        items: [
          OrderItem(productId: '1', quantity: 2, price: 500.0),
          OrderItem(productId: '2', quantity: 1, price: 1200.0),
        ],
        status: 'Delivered',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Order(
        id: 'ORD002',
        dealerId: 'dealer2',
        srId: 'sr1',
        items: [
          OrderItem(productId: '3', quantity: 5, price: 100.0),
        ],
        status: 'Packed',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
      ),
    ];
  }
}
