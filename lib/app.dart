import 'package:flutter/material.dart';
import 'package:meal_calculator/view/home/home_view.dart';

class MealCalculator extends StatefulWidget {
  const MealCalculator({super.key});

  @override
  State<MealCalculator> createState() => _MealCalculatorState();
}

class _MealCalculatorState extends State<MealCalculator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.lightBlueAccent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
      ),
      home: const HomeView(),
    );
  }
}
