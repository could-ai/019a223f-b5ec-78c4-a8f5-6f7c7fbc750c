import 'package:flutter/material.dart';
import '../models/product.dart';

class OrderItem {
  final String productId;
  int quantity;
  final double price;
  final Product? product;
  
  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
    this.product,
  });
  
  double get total => quantity * price;
  
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'qty': quantity,
      'price': price,
    };
  }
}

class Order {
  final String? id;
  final String? dealerId;
  final String? srId;
  final List<OrderItem> items;
  double discount;
  double tax;
  double total;
  String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  Order({
    this.id,
    this.dealerId,
    this.srId,
    required this.items,
    this.discount = 0.0,
    this.tax = 0.0,
    this.total = 0.0,
    this.status = 'Pending',
    this.createdAt,
    this.updatedAt,
  });
  
  factory Order.empty() {
    return Order(items: []);
  }
  
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      dealerId: json['dealer_id'],
      srId: json['sr_id'],
      items: (json['items'] as List)
          .map((item) => OrderItem(
                productId: item['product_id'],
                quantity: item['qty'],
                price: item['price'].toDouble(),
              ))
          .toList(),
      discount: json['discount']?.toDouble() ?? 0.0,
      tax: json['tax']?.toDouble() ?? 0.0,
      total: json['total'].toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dealer_id': dealerId,
      'sr_id': srId,
      'items': items.map((item) => item.toJson()).toList(),
      'discount': discount,
      'tax': tax,
      'total': total,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
  
  void calculateTotal() {
    double subtotal = items.fold(0.0, (sum, item) => sum + item.total);
    total = subtotal - discount + tax;
  }
}