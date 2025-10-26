import 'package:flutter/material.dart';

class InvoiceHistoryScreen extends StatelessWidget {
  const InvoiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock invoice data
    final invoices = [
      {'id': 'INV001', 'orderId': 'ORD001', 'amount': 2500.0, 'date': '2024-01-15', 'status': 'Paid'},
      {'id': 'INV002', 'orderId': 'ORD002', 'amount': 1800.0, 'date': '2024-01-10', 'status': 'Paid'},
      {'id': 'INV003', 'orderId': 'ORD003', 'amount': 3200.0, 'date': '2024-01-05', 'status': 'Pending'},
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice History'),
      ),
      body: ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          final invoice = invoices[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.receipt),
              title: Text('Invoice ${invoice['id']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order: ${invoice['orderId']}'),
                  Text('Date: ${invoice['date']}'),
                  Text(
                    'Status: ${invoice['status']}',
                    style: TextStyle(
                      color: invoice['status'] == 'Paid' ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
              trailing: Text(
                '৳${invoice['amount']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // View/download invoice PDF
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Viewing invoice ${invoice['id']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
