import 'package:expense_tracker_sqflite_provider/Providers/expense_provider.dart';
import 'package:expense_tracker_sqflite_provider/Providers/drop_down_provider.dart';
import 'package:expense_tracker_sqflite_provider/Providers/transaction_provider.dart';
import 'package:expense_tracker_sqflite_provider/Views/btm_nav_bar.dart';
import 'package:expense_tracker_sqflite_provider/Providers/category_provider.dart';
import 'package:expense_tracker_sqflite_provider/Views/category_screen.dart';
import 'package:expense_tracker_sqflite_provider/Views/expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => DropdownProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => AddExpenseProvider()),
        ChangeNotifierProvider(create: (context) => TransactionTypeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      routes: {
        CategoryScreen.name: (context) => const CategoryScreen(),
        ExpenseScreen.name: (context) => const ExpenseScreen(),
      },
      home: BottomNavBar(),
    );
  }
}
