import 'package:expense_tracker_sqflite_provider/Providers/add_expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});
  static const name = "expense_screen";

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddExpenseProvider>().getExpense();
    });
    return Scaffold(
      appBar: AppBar(title: Text("Expense Screen")),
      body: Center(
        child: Column(
          children: [
            Consumer<AddExpenseProvider>(
              builder: (context, provider, child) {
                return provider.expenseList.isEmpty
                    ? Center(child: Text("No expenses found!"))
                    : Expanded(
                      child: ListView.builder(itemCount: provider.expenseList.length,
                        itemBuilder: (context, index) {
                          final expense = provider.expenseList[index];
                          return ListTile(
                            title: Text(expense.title),
                            subtitle: Text("\$${expense.amount}"),
                            trailing: Text(expense.date.toString().split(" ")[0]),
                          );
                        },
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
