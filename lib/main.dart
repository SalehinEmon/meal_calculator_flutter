import 'package:flutter/material.dart';
import 'package:meal_calculator/app.dart';
import 'package:meal_calculator/presentation/home/provider/mess_calculator_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MessCalculatorProvider(),
    child: const MealCalculator(),
  ));
}
