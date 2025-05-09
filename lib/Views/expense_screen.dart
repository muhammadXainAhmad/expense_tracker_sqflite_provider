import 'package:expense_tracker_sqflite_provider/Constants/icons.dart';
import 'package:expense_tracker_sqflite_provider/Providers/expense_provider.dart';
import 'package:expense_tracker_sqflite_provider/Views/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});
  static const name = "expense_screen";

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseProvider>().getExpense();
    });
    return Scaffold(
      appBar: AppBar(title: Text("Expense Screen")),
      body: Center(
        child: Column(
          children: [
            Consumer<ExpenseProvider>(
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
                              child: Dismissible(
                                key: ValueKey(expense.id),
                                background: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                secondaryBackground: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),

                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    provider.setUpdateFlag(
                                      true,
                                      expense.id,
                                      expense.title,
                                      expense.amount,
                                      expense.category,
                                      expense.type,
                                      expense.date,
                                    );
                                    await showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder:
                                          (context) => SizedBox(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.75,
                                            child: AddExpenseScreen(),
                                          ),
                                    );
                                    return false;
                                  } else {
                                    return true;
                                  }
                                },
                                onDismissed: (direction) {
                                  provider.deleteExpenseItem(expense.id);
                                },
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
                                        icons[expense.category] ??
                                            Icons.category,
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
