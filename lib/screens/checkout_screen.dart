import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _address = '';
  String _cardNumber = '';
  String _expiryDate = '';
  String _cvv = '';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? product =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (product == null || product.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Checkout'),
        ),
        body: Center(
          child: Text('No product details available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product Details',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('Name: ${product['title']}',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Price: \$${product['price']}',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Customer Information',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Name'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _name = value!;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Address'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _address = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Credit Card Details',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Card Number'),
                            keyboardType: TextInputType.number,
                            maxLength: 16,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your card number';
                              } else if (value.length != 16) {
                                return 'Card number must be 16 digits';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _cardNumber = value!;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Expiry Date (MM/YY)'),
                            keyboardType: TextInputType.datetime,
                            maxLength: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the expiry date';
                              } else if (!RegExp(
                                      r'(0[1-9]|1[0-2])\/?([0-9]{2})$')
                                  .hasMatch(value)) {
                                return 'Enter a valid expiry date (MM/YY)';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _expiryDate = value!;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'CVV'),
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the CVV';
                              } else if (value.length != 3) {
                                return 'CVV must be 3 digits';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _cvv = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/categories',
                          (Route<dynamic> route) => false,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Purchase Confirmed')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
                    ),
                    child: Text(
                      'Confirm Purchase',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
