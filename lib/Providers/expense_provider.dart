import 'package:expense_tracker_sqflite_provider/Models/db_helper.dart';
import 'package:expense_tracker_sqflite_provider/Models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
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

  bool _isUpdate = false;
  bool get isUpdate => _isUpdate;
  int? _updateId;
  int? get updateId => _updateId;

  String? _updateTitle;
  String? get updateTitle => _updateTitle;

  double? _updateAmount;
  double? get updateAmount => _updateAmount;

  String? _updateCategory;
  String? get updateCategory => _updateCategory;

  String? _updateAmountType;
  String? get updateAmountType => _updateAmountType;

  DateTime? _updateDate;
  DateTime? get updateDate => _updateDate;

  void setUpdateFlag(
    bool value,
    int id,
    String title,
    double amount,
    String category,
    String amountType,
    DateTime date,
  ) {
    _isUpdate = value;
    _updateId = id;
    _updateTitle = title;
    _updateAmount = amount;
    _updateCategory = category;
    _updateAmountType = amountType;
    _updateDate = date;
    notifyListeners();
  }

  void updateExpenseItem({
    required int id,
    required String title,
    required double amount,
    required String category,
    required String amountType,
    required DateTime date,
  }) async {
    final expense = Expense(
      id: id,
      title: title,
      amount: amount,
      date: date,
      category: category,
      type: amountType,
    );
    await dbHelper.updateExpenseItem(expense);
    getExpense();
    notifyListeners();
  }

  void deleteExpenseItem(int id) async {
    await dbHelper.deleteExpenseItem(id);
    getExpense();
    notifyListeners();
  }
}
