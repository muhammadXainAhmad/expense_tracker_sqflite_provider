import 'package:expense_tracker_sqflite_provider/Models/db_helper.dart';
import 'package:expense_tracker_sqflite_provider/Models/expense_category_model.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  List<ExpenseCategory> _categories = [];
  final DBHelper dbHelper = DBHelper.instance;

  bool _isLoading = false;

  List<ExpenseCategory> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    _categories = await dbHelper.getCategory();

    _isLoading = false;
    notifyListeners();
  }
}
