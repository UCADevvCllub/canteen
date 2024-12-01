import 'package:flutter/material.dart';
import 'package:canteen/presentation/pages/catalog_page.dart'; // Import CatalogPage from the correct directory
import 'package:canteen/presentation/pages/auth/login_page.dart';  // Import LoginPage from the correct directory

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Catalogue',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/catalog', // Start with CatalogPage for testing
      routes: {
        '/login': (context) => const LoginPage(),
        '/catalog': (context) => const CatalogPage(),
      },
    );
  }
}
