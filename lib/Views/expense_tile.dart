import 'package:flutter/material.dart';
import 'package:expense_tracker_sqflite_provider/Constants/icons.dart';
import 'package:expense_tracker_sqflite_provider/Models/expense_model.dart';
import 'package:expense_tracker_sqflite_provider/Views/add_expense_screen.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker_sqflite_provider/Providers/expense_provider.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final bool enableDismissible;

  const ExpenseTile({
    super.key,
    required this.expense,
    this.enableDismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);

    Widget tile = ListTile(
      leading: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.circle,
            size: 50,
            color: categoryColors[expense.category] ?? Colors.grey,
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
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        "${expense.type} · ${expense.category}",
        style: const TextStyle(color: Colors.black, fontSize: 14),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "- \$${expense.amount}",
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            expense.date.toString().split(" ")[0],
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
            child: const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Icon(Icons.edit, color: Colors.white),
            ),
          ),
          secondaryBackground: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.centerRight,
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
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
                    (_) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: const AddExpenseScreen(),
                    ),
              );
              return false;
            }
            return true;
          },
          onDismissed: (_) {
            provider.deleteExpenseItem(expense.id);
          },
          child: tile,
        ),
      ),
    );
  }
}
