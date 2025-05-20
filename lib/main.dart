import 'package:flutter/material.dart';
import 'lab2_login.dart'; // Change to the screen you want to test
// import 'lab3_recipe_page.dart';
// import 'week2.dart'; // Only use one as home

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Lab2LoginPage(), // You can change this to other pages
    );
  }
}
