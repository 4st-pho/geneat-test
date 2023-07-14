import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/screens/home/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: const AppBarTheme(color: Colors.deepOrangeAccent),
      ),
      home: const HomeScreen(),
    );
  }
}
