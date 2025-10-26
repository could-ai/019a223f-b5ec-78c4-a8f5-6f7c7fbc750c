import 'package:flutter/material.dart';

class VisitListScreen extends StatelessWidget {
  const VisitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final dealers = [
      {'name': 'ABC Electronics', 'address': 'Dhaka, Bangladesh', 'lastVisit': '2 days ago', 'pendingOrders': 1},
      {'name': 'XYZ Traders', 'address': 'Chittagong, Bangladesh', 'lastVisit': '1 week ago', 'pendingOrders': 0},
      {'name': 'PQR Distributors', 'address': 'Khulna, Bangladesh', 'lastVisit': '3 days ago', 'pendingOrders': 2},
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visit List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              // TODO: Open map view
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dealers.length,
        itemBuilder: (context, index) {
          final dealer = dealers[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.store),
              ),
              title: Text(dealer['name'] as String),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dealer['address'] as String),
                  Text(
                    'Last visit: ${dealer['lastVisit']}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  if (dealer['pendingOrders'] as int > 0)
                    Text(
                      '${dealer['pendingOrders']} pending orders',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to create order for this dealer
                Navigator.pushNamed(context, '/create_order');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new dealer or quick order
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
