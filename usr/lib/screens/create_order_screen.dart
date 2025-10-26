import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../models/order.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  @override
  void initState() {
    super.initState();
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    // productProvider.loadProducts('area_id'); // TODO: Get from user
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    
    List filteredProducts = productProvider.products
        .where((product) => 
            product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            product.sku.toLowerCase().contains(_searchQuery.toLowerCase()))
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
            child: productProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredProducts.isEmpty
                    ? const Center(child: Text('No products found'))
                    : ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: filteredProducts[index],
                            onAddToCart: (product, quantity) {
                              orderProvider.addItemToOrder(
                                OrderItem(
                                  productId: product.id,
                                  quantity: quantity,
                                  price: product.price,
                                  product: product,
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${product.name} added to cart'),
                                ),
                              );
                            },
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