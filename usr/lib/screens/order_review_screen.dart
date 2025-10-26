import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';
import '../widgets/order_item_card.dart';

class OrderReviewScreen extends StatelessWidget {
  const OrderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final order = orderProvider.currentOrder;
    
    if (order == null || order.items.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Order Review')),
        body: const Center(child: Text('No items in order')),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Review'),
        actions: [
          TextButton(
            onPressed: () => _showDiscountDialog(context, orderProvider),
            child: const Text(
              'Apply Discount',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                return OrderItemCard(
                  item: order.items[index],
                  onRemove: () => orderProvider.removeItemFromOrder(index),
                  onUpdateQuantity: (quantity) => 
                      orderProvider.updateItemQuantity(index, quantity),
                );
              },
            ),
          ),
          // Order summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: const Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Column(
              children: [
                _buildSummaryRow('Subtotal', order.items.fold(0.0, (sum, item) => sum + item.total)),
                if (order.discount > 0) _buildSummaryRow('Discount', -order.discount),
                _buildSummaryRow('Tax', order.tax),
                const Divider(),
                _buildSummaryRow('Total', order.total, isTotal: true),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: orderProvider.isLoading
                        ? null
                        : () async {
                            bool success = await orderProvider.submitOrder();
                            if (success) {
                              Navigator.pushReplacementNamed(context, '/order_success');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(orderProvider.error ?? 'Failed to submit order'),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: orderProvider.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Submit Order'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : 16,
          ),
        ),
        Text(
          '৳${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : 16,
          ),
        ),
      ],
    );
  }
  
  void _showDiscountDialog(BuildContext context, OrderProvider orderProvider) {
    final TextEditingController discountController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apply Discount'),
        content: TextField(
          controller: discountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Discount Amount (৳)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final discount = double.tryParse(discountController.text) ?? 0.0;
              orderProvider.applyDiscount(discount);
              Navigator.pop(context);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}
