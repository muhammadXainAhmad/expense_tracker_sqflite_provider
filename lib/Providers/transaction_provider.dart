import 'package:flutter/material.dart';

class TransactionTypeProvider extends ChangeNotifier {
  String _transactionType = 'Expense';

  String get transactionType => _transactionType;

  void setTransactionType(String type) {
    _transactionType = type;
    notifyListeners();
  }

  void toggleType() {
    _transactionType = _transactionType == 'Expense' ? 'Income' : 'Expense';
    notifyListeners();
  }
}
