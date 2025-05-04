import 'package:expense_tracker_sqflite_provider/Models/db_helper.dart';
import 'package:expense_tracker_sqflite_provider/Models/expense_model.dart';
import 'package:flutter/material.dart';

class AddExpenseProvider with ChangeNotifier {
  DBHelper dbHelper = DBHelper.instance;

  bool _showPrefix = false;
  bool get showPrefix => _showPrefix;

  void updatePrefixText(String text) {
    _showPrefix = text.isNotEmpty;
    notifyListeners();
  }

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void addExpenseItem({
    required String title,
    required double amount,
    required String category,
    required String amountType,
    required DateTime date,
  }) async {
    final expense = Expense(
      id: 0,
      title: title,
      amount: amount,
      date: date,
      category: category,
      amountType: amountType,
    );
    await dbHelper.addExpenseItem(expense);
    notifyListeners();
  }
}
