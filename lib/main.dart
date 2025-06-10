import 'package:flutter/material.dart';
import 'lab5_login.dart';
import 'lab5_profile_page.dart';
import 'data_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataRepository.loadData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5 Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Lab5LoginPage(),
        '/profile': (context) => const Lab5ProfilePage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}