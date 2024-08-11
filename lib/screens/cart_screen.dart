import 'package:flutter/material.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart'; // Ensure you have a Product model for navigation

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartProvider _cartProvider = CartProvider();
  List<Map<String, dynamic>> _cartItems = [];
  Set<int> _selectedItems = Set();

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final items = await _cartProvider.getCart();
    setState(() {
      _cartItems = items;
    });
  }

  Future<void> _clearCart() async {
    await _cartProvider.clearCart();
    setState(() {
      _cartItems = [];
      _selectedItems.clear();
    });
  }

  void _navigateToProductDetail(Map<String, dynamic> product) {
    Navigator.pushNamed(
      context,
      '/productDetail', // Ensure this route is defined in your navigation
      arguments: product,
    );
  }

  void _buyNow() {
    // Filter selected items
    List<Map<String, dynamic>> selectedItems = _selectedItems.map((index) {
      return _cartItems[index];
    }).toList();

    // Navigate to the checkout screen with selected items
    Navigator.pushNamed(
      context,
      '/checkout', // Ensure this route is defined in your navigation
      arguments: selectedItems,
    );
  }

  double _calculateTotalPrice() {
    return _selectedItems.fold(0.0, (total, index) {
      return total + _cartItems[index]['price'];
    });
  }

  void _deleteSelectedItems() async {
    setState(() {
      _selectedItems.forEach((index) {
        _cartProvider.removeFromCart(_cartItems[index]);
      });
      _cartItems.removeWhere(
          (item) => _selectedItems.contains(_cartItems.indexOf(item)));
      _selectedItems.clear();
    });

    // Update the cart in SharedPreferences
    await _cartProvider.clearCart(); // Clear the old cart
    for (var item in _cartItems) {
      await _cartProvider.addToCart(item); // Add the remaining items back
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          if (_selectedItems.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: _deleteSelectedItems,
            ),
        ],
      ),
      body: _cartItems.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _cartItems.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        leading: Image.network(
                          item['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        title: Text(
                          item['title'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('\$${item['price'].toStringAsFixed(2)}'),
                        trailing: Checkbox(
                          value: _selectedItems.contains(index),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                _selectedItems.add(index);
                              } else {
                                _selectedItems.remove(index);
                              }
                            });
                          },
                        ),
                        onTap: () => _navigateToProductDetail(item),
                      );
                    },
                  ),
                ),
                if (_selectedItems.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Total: \$${_calculateTotalPrice().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // _clearCart();
                            _buyNow();
                          },
                          child: Text('Buy Now'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
