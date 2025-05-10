import 'package:expense_tracker_sqflite_provider/Providers/expense_provider.dart';
import 'package:expense_tracker_sqflite_provider/Providers/transaction_provider.dart';
import 'package:expense_tracker_sqflite_provider/Views/expense_tile.dart';
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
      appBar: AppBar(
        title: Text(
          "Transactions",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<TransactionTypeProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ToggleButtons(
                  isSelected: [
                    provider.transactionType == 'Expense',
                    provider.transactionType == 'Income',
                  ],
                  onPressed: (index) {
                    provider.setTransactionType(
                      index == 0 ? 'Expense' : 'Income',
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  selectedColor: Colors.black,
                  color: Colors.grey.shade600,
                  fillColor: Colors.tealAccent.shade400,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 55),
                      child: Text('Expenses', style: TextStyle(fontSize: 18)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 55),
                      child: Text('Income', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              );
            },
          ),
          Consumer<ExpenseProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return provider.expenseList.isEmpty
                  ? Expanded(
                    child: Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
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
                    ),
                  )
                  : Expanded(
                    child: ListView.builder(
                      itemCount: provider.expenseList.length,
                      itemBuilder: (context, index) {
                        final expense = provider.expenseList[index];
                        return ExpenseTile(expense: expense);
                      },
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
