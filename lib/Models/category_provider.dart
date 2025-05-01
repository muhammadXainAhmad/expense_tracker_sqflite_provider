import 'package:expense_tracker_sqflite_provider/Models/db_helper.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    _categories = await DBHelper().getCategory();

    _isLoading = false;
    notifyListeners();
  }
}
