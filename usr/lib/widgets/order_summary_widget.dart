import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderSummaryWidget extends StatelessWidget {
  final Order order;
  
  const OrderSummaryWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Order ID', order.id ?? 'N/A'),
            _buildSummaryRow('Status', order.status),
            _buildSummaryRow('Items', order.items.length.toString()),
            _buildSummaryRow('Total Amount', '৳${order.total.toStringAsFixed(2)}'),
            if (order.discount > 0)
              _buildSummaryRow('Discount', '৳${order.discount.toStringAsFixed(2)}'),
            _buildSummaryRow('Date', order.createdAt?.toString().split(' ')[0] ?? 'N/A'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
