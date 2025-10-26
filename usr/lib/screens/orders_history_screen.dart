import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/order_card.dart';

class OrdersHistoryScreen extends StatefulWidget {
  const OrdersHistoryScreen({super.key});

  @override
  State<OrdersHistoryScreen> createState() => _OrdersHistoryScreenState();
}

class _OrdersHistoryScreenState extends State<OrdersHistoryScreen> {
  String _selectedStatus = 'All';
  final List<String> _statusOptions = ['All', 'Pending', 'Packed', 'Dispatched', 'Delivered'];
  
  @override
  void initState() {
    super.initState();
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    
    List filteredOrders = orderProvider.orders.where((order) {
      if (_selectedStatus == 'All') return true;
      return order.status == _selectedStatus;
    }).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (status) {
              setState(() {
                _selectedStatus = status;
              });
            },
            itemBuilder: (context) => _statusOptions.map((status) => 
              PopupMenuItem(
                value: status,
                child: Text(status),
              )
            ).toList(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => orderProvider.loadOrders(),
        child: orderProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : filteredOrders.isEmpty
                ? const Center(child: Text('No orders found'))
                : ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      return OrderCard(
                        order: filteredOrders[index],
                        showDealerInfo: authProvider.isSR,
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          orderProvider.startNewOrder();
          if (authProvider.isSR) {
            Navigator.pushNamed(context, '/visit_list');
          } else {
            Navigator.pushNamed(context, '/catalog');
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
