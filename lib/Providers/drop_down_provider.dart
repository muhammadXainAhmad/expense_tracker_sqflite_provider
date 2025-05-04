import 'package:flutter/material.dart';

class DropdownProvider with ChangeNotifier {
  String _selectedValue1 = 'Cash';
  String _selectedValue2 = 'Bills';

  String get selectedValue1 => _selectedValue1;
  String get selectedValue2 => _selectedValue2;

  void updateSelectedValue1(String newValue) {
    _selectedValue1 = newValue;
    notifyListeners();
  }
  void updateSelectedValue2(String newValue) {
    _selectedValue2 = newValue;
    notifyListeners();
  }
}
