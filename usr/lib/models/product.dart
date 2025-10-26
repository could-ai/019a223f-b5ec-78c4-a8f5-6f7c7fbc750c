class Product {
  final String id;
  final String sku;
  final String name;
  final double price;
  final double mrp;
  final String unit;
  final Map<String, int> stockByWarehouse;
  final List<String> images;
  
  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.price,
    required this.mrp,
    required this.unit,
    required this.stockByWarehouse,
    required this.images,
  });
  
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      sku: json['sku'],
      name: json['name'],
      price: json['price'].toDouble(),
      mrp: json['mrp'].toDouble(),
      unit: json['unit'],
      stockByWarehouse: Map<String, int>.from(json['stock_by_warehouse']),
      images: List<String>.from(json['images']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sku': sku,
      'name': name,
      'price': price,
      'mrp': mrp,
      'unit': unit,
      'stock_by_warehouse': stockByWarehouse,
      'images': images,
    };
  }
  
  int getStockForArea(String areaId) {
    return stockByWarehouse[areaId] ?? 0;
  }
}
