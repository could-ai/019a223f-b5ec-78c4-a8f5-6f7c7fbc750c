import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final bool showDealerInfo;
  
  const OrderCard({
    super.key,
    required this.order,
    this.showDealerInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (order.status) {
      case 'Pending':
        statusColor = Colors.orange;
        break;
      case 'Packed':
        statusColor = Colors.blue;
        break;
      case 'Dispatched':
        statusColor = Colors.purple;
        break;
      case 'Delivered':
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id ?? 'N/A'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            if (showDealerInfo && order.dealerId != null) ...[
              const SizedBox(height: 8),
              Text('Dealer: ${order.dealerId}'),
            ],
            const SizedBox(height: 8),
            Text('${order.items.length} items • Total: ৳${order.total.toStringAsFixed(2)}'),
            const SizedBox(height: 4),
            Text(
              'Date: ${order.createdAt?.toString().split(' ')[0] ?? 'N/A'}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
