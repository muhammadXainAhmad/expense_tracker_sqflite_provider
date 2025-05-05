import 'package:expense_tracker_sqflite_provider/Constants/icons.dart';
import 'package:expense_tracker_sqflite_provider/Providers/expense_provider.dart';
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
                      child: ListView.builder(
                        itemCount: provider.expenseList.length,
                        itemBuilder: (context, index) {
                          final expense = provider.expenseList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 2,
                              color: Colors.tealAccent.shade200,
                              child: ListTile(
                                leading: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 50,
                                      color:
                                          categoryColors[expense.category] ??
                                          Colors.grey,
                                    ),
                                    Icon(
                                      icons[expense.category] ?? Icons.category,
                                      size: 26,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                title: Text(
                                  expense.title,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  "${expense.type} · ${expense.category}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "- \$${expense.amount}",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      expense.date.toString().split(" ")[0],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
