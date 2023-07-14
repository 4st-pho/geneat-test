import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/constant/app_colors.dart';
import 'package:flutter_budget_ui/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(color: AppColors.primary),
      ),
      home: const HomeScreen(),
    );
  }
}
