import 'package:expense_tracker_sqflite_provider/Models/expense_model.dart';
import 'package:expense_tracker_sqflite_provider/Providers/expense_provider.dart';
import 'package:expense_tracker_sqflite_provider/Views/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryExpenseScreen extends StatelessWidget {
  const CategoryExpenseScreen({super.key});
  static const name = "category_expense_screen";

  @override
  Widget build(BuildContext context) {
    final String categoryTitle =
        ModalRoute.of(context)!.settings.arguments as String;
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    List<Expense> filteredExpenses =
        expenseProvider.expenseList
            .where((e) => e.category == categoryTitle)
            .toList();
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body:
          filteredExpenses.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.do_not_disturb_alt_outlined,
                      size: 150,
                      color: Colors.tealAccent.shade400,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "No Data Available",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              )
              : Expanded(
                child: ListView.builder(
                  itemCount: filteredExpenses.length,
                  itemBuilder: (context, index) {
                    final expense = filteredExpenses[index];
                    return ExpenseTile(expense: expense);
                  },
                ),
              ),
    );
  }
}
