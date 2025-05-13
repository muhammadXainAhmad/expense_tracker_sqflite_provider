import 'package:expense_tracker_sqflite_provider/Models/db_helper.dart';
import 'package:expense_tracker_sqflite_provider/Models/expense_category_model.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  final DBHelper dbHelper = DBHelper.instance;

  List<ExpenseCategory> _categories = [];
  List<ExpenseCategory> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void fetchCategories() async {
    _isLoading = true;
    notifyListeners();
    _categories = await dbHelper.getCategory();
    _isLoading = false;
    notifyListeners();
  }
}
