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

  bool _isExpenseAdded = false;
  bool get isExpenseAdded => _isExpenseAdded;

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
      type: amountType,
    );
    await dbHelper.addExpenseItem(expense);
    getExpense();
    _isExpenseAdded = true;
    notifyListeners();
  }

  void resetExpenseAddedFlag() {
    _isExpenseAdded = false;
    notifyListeners();
  }

  List<Expense> _expenseList = [];
  List<Expense> get expenseList => _expenseList;

  void getExpense() async {
    List<Expense> expenses = await dbHelper.getExpense();
    expenses.sort((a, b) => b.date.compareTo(a.date));
    _expenseList = expenses;
    notifyListeners();
  }
}
