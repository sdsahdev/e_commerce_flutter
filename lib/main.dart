import 'package:e_commerce_flutter/screens/cart_screen.dart';
import 'package:e_commerce_flutter/screens/category_screen.dart';
import 'package:e_commerce_flutter/screens/checkout_screen.dart';
import 'package:e_commerce_flutter/screens/detail_screen.dart';
import 'package:e_commerce_flutter/screens/product_detail_screen.dart';
import 'package:e_commerce_flutter/screens/product_screen.dart';
import 'package:e_commerce_flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/products': (context) => ProductScreen(
              category: ModalRoute.of(context)!.settings.arguments as String,
            ),
        '/productDetail': (context) => ProductDetailScreen(
            product: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        '/detail': (context) => DetailScreen(),
        '/checkout': (context) => CheckoutScreen(),
        '/categories': (context) => CategoryScreen(),
        '/cart': (context) => CartScreen(), // Add the Cart route
      },
    );
  }
}
