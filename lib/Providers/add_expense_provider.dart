import 'package:flutter/material.dart';

class AddExpenseProvider with ChangeNotifier {
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

  void addExpenseItem() async {}
}
