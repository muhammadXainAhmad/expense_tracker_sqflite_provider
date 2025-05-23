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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Expense> _expenseList = [];
  List<Expense> get expenseList => _expenseList;

  double _totalIncome = 0;
  double get totalIncome => _totalIncome;

  double _totalExpense = 0;
  double get totalExpense => _totalExpense;

  Map<String, double> _categoryExpenseTotals = {};
  Map<String, double> get categoryExpenseTotals => _categoryExpenseTotals;

  double _balance = 0;
  double get balance => _balance;

  Future<void> getExpense() async {
    _isLoading = true;
    notifyListeners();
    List<Expense> expenses = await dbHelper.getExpense();
    expenses.sort((a, b) => b.date.compareTo(a.date));
    _expenseList = expenses;

    _totalIncome = 0;
    _totalExpense = 0;
    _categoryExpenseTotals = {};
    _balance = 0;
    for (var expense in expenses) {
      if (expense.transactionType == "Income") {
        _totalIncome += expense.amount;
      } else {
        _totalExpense += expense.amount;
        _categoryExpenseTotals.update(
          expense.category,
          (existing) => existing + expense.amount,
          ifAbsent: () => expense.amount,
        );
      }
    }
    _balance = _totalIncome - _totalExpense;

    _isLoading = false;
    notifyListeners();
  }

  String _selectedType = "Expense";
  String get selectedType => _selectedType;

  void setSelectedType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  List<Expense> get filteredExpenses {
    return _expenseList
        .where((e) => e.transactionType == _selectedType)
        .toList();
  }

  String _filterTransactionType = 'Expense';
  String get filterTransactionType => _filterTransactionType;

  void setFilterTransactionType(String type) {
    _filterTransactionType = type;
    notifyListeners();
  }

  Future<void> addExpenseItem({
    required String title,
    required double amount,
    required String category,
    required String paymentType,
    required DateTime date,
    required String transactionType,
  }) async {
    final expense = Expense(
      id: 0,
      title: title,
      amount: amount,
      date: date,
      category: category,
      paymentType: paymentType,
      transactionType: transactionType,
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

  String? _transactionType;
  String? get transactionType => _transactionType;

  DateTime? _updateDate;
  DateTime? get updateDate => _updateDate;

  void setUpdateFlag(
    bool value,
    int id,
    String title,
    double amount,
    String category,
    String amountType,
    String transactionType,
    DateTime date,
  ) {
    _isUpdate = value;
    _updateId = id;
    _updateTitle = title;
    _updateAmount = amount;
    _updateCategory = category;
    _updateAmountType = amountType;
    _transactionType = transactionType;
    _updateDate = date;
    notifyListeners();
  }

  Future<void> updateExpenseItem({
    required int id,
    required String title,
    required double amount,
    required String category,
    required String paymentType,
    required String transactionType,
    required DateTime date,
  }) async {
    final expense = Expense(
      id: id,
      title: title,
      amount: amount,
      date: date,
      category: category,
      paymentType: paymentType,
      transactionType: transactionType,
    );
    await dbHelper.updateExpenseItem(expense);
    getExpense();
    notifyListeners();
  }

  Future<void> deleteExpenseItem(int id) async {
    await dbHelper.deleteExpenseItem(id);
    getExpense();
    expenseList.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  List<Expense> getTodayExpenses() {
    final now = DateTime.now();
    return expenseList.where((expense) {
      return expense.date.year == now.year &&
          expense.date.month == now.month &&
          expense.date.day == now.day &&
          expense.transactionType == "Expense";
    }).toList();
  }

  List<Expense> getWeekExpenses() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));

    return expenseList.where((expense) {
      return expense.date.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
          expense.date.isBefore(endOfWeek.add(Duration(days: 1))) &&
          expense.transactionType == "Expense";
    }).toList();
  }

  List<Expense> getMonthExpenses() {
    final now = DateTime.now();
    return expenseList.where((expense) {
      return expense.date.year == now.year &&
          expense.date.month == now.month &&
          expense.transactionType == "Expense";
    }).toList();
  }

  double getTotal(List<Expense> expenses) {
    return expenses.fold(0, (sum, item) => sum + item.amount);
  }
}
