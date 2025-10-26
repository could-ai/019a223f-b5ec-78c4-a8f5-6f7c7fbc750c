import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../widgets/order_item_card.dart';

class DealerCreateOrderScreen extends StatefulWidget {
  const DealerCreateOrderScreen({super.key});

  @override
  State<DealerCreateOrderScreen> createState() => _DealerCreateOrderScreenState();
}

class _DealerCreateOrderScreenState extends State<DealerCreateOrderScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  @override
  void initState() {
    super.initState();
    // Load products for dealer's area
    // final productProvider = Provider.of<ProductProvider>(context, listen: false);
    // productProvider.loadProducts('dealer_area');
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    
    // Mock products for demonstration
    final mockProducts = [
      {'id': '1', 'name': 'Product A', 'price': 100.0, 'unit': 'pcs', 'stock': 50},
      {'id': '2', 'name': 'Product B', 'price': 200.0, 'unit': 'pcs', 'stock': 30},
      {'id': '3', 'name': 'Product C', 'price': 150.0, 'unit': 'pcs', 'stock': 20},
    ];
    
    List filteredProducts = mockProducts
        .where((product) => 
            (product['name'] as String).toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Order'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              if (orderProvider.currentOrder?.items.isNotEmpty ?? false) {
                Navigator.pushNamed(context, '/order_review');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Product list
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.inventory),
                    ),
                    title: Text(product['name'] as String),
                    subtitle: Text('৳${product['price']} • Stock: ${product['stock']} ${product['unit']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // Add to cart logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product['name']} added to cart')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          // Cart summary
          if (orderProvider.currentOrder?.items.isNotEmpty ?? false)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${orderProvider.currentOrder!.items.length} items',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Total: ৳${orderProvider.currentOrder!.total.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/order_review'),
                    child: const Text('Review Order'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
