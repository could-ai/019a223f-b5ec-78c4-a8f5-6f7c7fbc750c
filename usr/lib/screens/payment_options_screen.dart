import 'package:flutter/material.dart';

class PaymentOptionsScreen extends StatelessWidget {
  const PaymentOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Options'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Card(
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet, color: Colors.blue),
                title: const Text('Cash on Delivery'),
                subtitle: const Text('Pay when you receive the order'),
                onTap: () {
                  // Process cash on delivery
                  Navigator.pushNamed(context, '/order_success');
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.credit_card, color: Colors.green),
                title: const Text('Online Payment'),
                subtitle: const Text('Pay securely with SSLCommerz'),
                onTap: () {
                  // Integrate SSLCommerz payment
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Online payment integration coming soon')),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.business, color: Colors.orange),
                title: const Text('Credit Account'),
                subtitle: const Text('Charge to dealer credit account'),
                onTap: () {
                  // Process credit payment
                  Navigator.pushNamed(context, '/order_success');
                },
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Payment will be processed securely',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
