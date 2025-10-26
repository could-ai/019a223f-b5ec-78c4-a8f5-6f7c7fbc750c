import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerator {
  static Future<void> generateInvoicePdf(Order order) async {
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Header(
              level: 0,
              child: pw.Text('Invoice', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ),
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
            pw.Text('Subtotal: ৳${order.items.fold(0.0, (sum, item) => sum + item.total).toStringAsFixed(2)}'),
            if (order.discount > 0) pw.Text('Discount: ৳${order.discount.toStringAsFixed(2)}'),
            pw.Text('Tax: ৳${order.tax.toStringAsFixed(2)}'),
            pw.Divider(),
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
