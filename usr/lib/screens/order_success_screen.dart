import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
// import '../services/notification_service.dart'; // Commented out

import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final order = orderProvider.orders.last; // Assuming the last order is the submitted one
    
    // Send notification
    // NotificationService().showLocalNotification( // Commented out
    //   'Order Submitted',
    //   'Your order #${order.id} has been submitted successfully!',
    // );
    
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              const Text(
                'Order Submitted Successfully!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Order ID: ${order.id ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Order Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Items: ${order.items.length}'),
                      Text('Total: ৳${order.total.toStringAsFixed(2)}'),
                      Text('Status: ${order.status}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _generateAndViewPDF(context, order),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('View Invoice'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/dashboard',
                        (route) => false,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Back to Dashboard'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> _generateAndViewPDF(BuildContext context, order) async {
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Invoice', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Order ID: ${order.id ?? 'N/A'}'),
            pw.Text('Date: ${order.createdAt?.toString() ?? 'N/A'}'),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: ['Product', 'Qty', 'Price', 'Total'],
              data: order.items.map((item) => [
                item.product?.name ?? 'Product',
                item.quantity.toString(),
                '৳${item.price.toStringAsFixed(2)}',
                '৳${item.total.toStringAsFixed(2)}',
              ]).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Total: ৳${order.total.toStringAsFixed(2)}', 
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ],
        ),
      ),
    );
    
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}